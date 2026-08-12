import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Luxury Monogram Badge
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC59B27).withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "L",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'serif',
                color: Color(0xFFB88E3E),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Brand Sub-heading "M A I S O N"
        const Text(
          "M A I S O N",
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 4.5,
            color: Color(0xFFB88E3E),
          ),
        ),
        const SizedBox(height: 6),

        // Brand Title "Lumière."
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Lumière",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'serif',
                  color: Color(0xFF16231E),
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: ".",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'serif',
                  color: Color(0xFFC59B27),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle
        const Text(
          "Welcome back to curated luxury",
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
            color: Color(0xFF5A6961),
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}
