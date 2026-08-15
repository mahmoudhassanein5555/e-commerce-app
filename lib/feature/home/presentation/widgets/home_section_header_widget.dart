import 'package:flutter/material.dart';

class HomeSectionHeaderWidget extends StatelessWidget {
  const HomeSectionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.actionTitle = 'See all',
    this.onActionTap,
  });

  final String title;
  final String subtitle;
  final String actionTitle;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF121212),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF888888),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onActionTap,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              actionTitle,
              style: const TextStyle(
                color: Color(0xFFC08941),
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

