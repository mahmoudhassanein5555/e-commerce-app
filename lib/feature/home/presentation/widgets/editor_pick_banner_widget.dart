import 'package:e_commerce_app/core/common/widget/safe_network_image.dart';
import 'package:flutter/material.dart';

/// Editor's Pick banner widget — matches the design layout:
/// product image container on the left, luxury editorial text on the right.
class EditorPickBannerWidget extends StatelessWidget {
  const EditorPickBannerWidget({super.key});

  static const String _perfumeImageUrl =
      'https://images.unsplash.com/photo-1541643600914-78b084683702?w=400&q=80';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFECE7DE),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left: Product image container
            Container(
              width: 115,
              color: const Color(0xFFF0EBE0),
              child: const SafeNetworkImage(
                imageUrl: _perfumeImageUrl,
                fit: BoxFit.cover,
                placeholderColor: Color(0xFFF0EBE0),
                iconColor: Color(0xFFBBA97A),
                iconSize: 32,
              ),
            ),
            // Right: Editorial text content & CTA
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "EDITOR'S PICK",
                      style: TextStyle(
                        color: Color(0xFFC08941),
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'The Quiet Collection',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Curated objects for stillness and shine.',
                      style: TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 11,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Explore +',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

