import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A robust, centralized image widget that handles all failure modes gracefully.
///
/// - If [imageUrl] is null or empty → shows a clean placeholder immediately.
/// - If the network image fails to load → shows the same clean placeholder.
/// - Shows an optional shimmer-like loading state while the image loads.
///
/// Use this widget everywhere a product/remote image is displayed so that
/// the fallback behaviour is consistent across the entire app.
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.placeholderColor,
    this.iconColor,
    this.iconSize = 36,
  });

  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  /// Background color of the placeholder box. Defaults to a soft grey.
  final Color? placeholderColor;

  /// Icon color for the placeholder icon. Defaults to a mid-grey.
  final Color? iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bool hasUrl = imageUrl != null && imageUrl!.trim().isNotEmpty;

    Widget imageWidget;
    if (hasUrl) {
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) => _Placeholder(
          placeholderColor: placeholderColor,
          iconColor: iconColor,
          iconSize: iconSize,
          isLoading: true,
        ),
        errorWidget: (context, url, error) => _Placeholder(
          placeholderColor: placeholderColor,
          iconColor: iconColor,
          iconSize: iconSize,
          isLoading: false,
        ),
      );
    } else {
      imageWidget = _Placeholder(
        placeholderColor: placeholderColor,
        iconColor: iconColor,
        iconSize: iconSize,
        isLoading: false,
      );
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: SizedBox(width: width, height: height, child: imageWidget),
      );
    }

    return SizedBox(width: width, height: height, child: imageWidget);
  }
}

/// Internal placeholder shown when no image is available or loading fails.
class _Placeholder extends StatelessWidget {
  const _Placeholder({
    this.placeholderColor,
    this.iconColor,
    required this.iconSize,
    required this.isLoading,
  });

  final Color? placeholderColor;
  final Color? iconColor;
  final double iconSize;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: placeholderColor ?? const Color(0xFFE8E8E8),
      child: Center(
        child: isLoading
            ? SizedBox(
                width: iconSize,
                height: iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: iconColor ?? const Color(0xFFB0B0B0),
                ),
              )
            : Icon(
                Icons.image_not_supported_outlined,
                size: iconSize,
                color: iconColor ?? const Color(0xFFB0B0B0),
              ),
      ),
    );
  }
}
