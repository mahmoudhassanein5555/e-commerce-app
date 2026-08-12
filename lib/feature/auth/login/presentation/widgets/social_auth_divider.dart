import 'package:flutter/material.dart';

class SocialAuthDivider extends StatelessWidget {
  const SocialAuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFDCE4E0),
            thickness: 1.0,
            endIndent: 14,
          ),
        ),
        Text(
          "OR CONTINUE WITH",
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
            color: Color(0xFF7A8B83),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFDCE4E0),
            thickness: 1.0,
            indent: 14,
          ),
        ),
      ],
    );
  }
}
