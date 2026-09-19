import 'package:flutter/material.dart';

class TrendingTagsWidget extends StatelessWidget {
  final List<String> tags;
  final ValueChanged<String>? onTagTap;

  const TrendingTagsWidget({
    super.key,
    this.tags = const [
      'Test',
      'Product',
      'Test Product',
      'Product 1',
      'Product 2',
    ],
    this.onTagTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TRENDING',
          style: TextStyle(
            color: Color(0xFFBA9E56),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: tags.map((tag) {
            return GestureDetector(
              onTap: () => onTagTap?.call(tag),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE8F0E7),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.025),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C382E),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

