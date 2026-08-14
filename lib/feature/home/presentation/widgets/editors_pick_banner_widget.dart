import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditorsPickBannerWidget extends StatelessWidget {
  const EditorsPickBannerWidget({
    super.key,
    this.onExploreTap,
    this.imageUrl =
        'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?auto=format&fit=crop&w=400&q=80',
    this.tag = "EDITOR'S PICK",
    this.title = 'The Quiet Collection',
    this.description = 'Curated objects for stillness and shine.',
  });

  final VoidCallback? onExploreTap;
  final String imageUrl;
  final String tag;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F2),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFFF1EAE0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Product Arched/Rounded Thumbnail Frame
          Container(
            width: 105,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFFE2EFE6),
              borderRadius: BorderRadius.circular(26),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: const Color(0xFFE2EFE6),
                  child: const Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFB88939),
                        ),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFFE2EFE6),
                  child: const Center(
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFFB88939),
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Right Content Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tag,
                  style: const TextStyle(
                    color: Color(0xFFB88939),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF101F1A),
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF55655F),
                    fontSize: 12,
                    height: 1.35,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: onExploreTap,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF091813),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
