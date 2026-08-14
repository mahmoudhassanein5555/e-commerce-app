import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    super.key,
    this.title = 'For you',
    this.subtitle = 'Hand-selected · Updated daily',
    this.actionText = 'See all',
    this.onSeeAllTap,
  });

  final String title;
  final String subtitle;
  final String actionText;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          if (actionText.isNotEmpty)
            InkWell(
              onTap: onSeeAllTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  actionText,
                  style: const TextStyle(
                    color: Color(0xFFB08233),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
