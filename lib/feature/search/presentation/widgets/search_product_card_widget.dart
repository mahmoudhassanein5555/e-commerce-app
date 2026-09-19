import 'package:e_commerce_app/core/common/widget/safe_network_image.dart';
import 'package:flutter/material.dart';

class SearchProductCardWidget extends StatefulWidget {
  final String brand;
  final String title;
  final String price;
  final bool isFavorite;
  final Color thumbnailBgColor;
  final IconData? icon;
  final String? imageUrl;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTap;

  const SearchProductCardWidget({
    super.key,
    required this.brand,
    required this.title,
    required this.price,
    this.isFavorite = false,
    this.thumbnailBgColor = const Color(0xFFDCEAD9),
    this.icon,
    this.imageUrl,
    this.onFavoriteTap,
    this.onTap,
  });

  @override
  State<SearchProductCardWidget> createState() =>
      _SearchProductCardWidgetState();
}

class _SearchProductCardWidgetState extends State<SearchProductCardWidget> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(covariant SearchProductCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String displayBrand = widget.brand.trim().isNotEmpty
        ? widget.brand.toUpperCase()
        : 'MAISON COLLECTION';

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: const Color(0xFFE8F1E7),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Circular Product Thumbnail
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.thumbnailBgColor,
              ),
              child: ClipOval(
                child: widget.imageUrl != null &&
                        widget.imageUrl!.trim().isNotEmpty
                    ? SafeNetworkImage(
                        imageUrl: widget.imageUrl,
                        width: 66,
                        height: 66,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        widget.icon ?? Icons.shopping_bag_outlined,
                        size: 30,
                        color: const Color(0xFF384639),
                      ),
              ),
            ),
            const SizedBox(width: 14),

            // Product Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    displayBrand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3,
                      color: Color(0xFF8BA08E),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF222B23),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF222B23),
                    ),
                  ),
                ],
              ),
            ),

            // Favorite Heart Button
            IconButton(
              icon: Icon(
                _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: _isFavorite
                    ? const Color(0xFFC59B27)
                    : const Color(0xFF9AA99C),
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
                widget.onFavoriteTap?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}

