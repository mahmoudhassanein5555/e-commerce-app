import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  /// Calculates password strength score from 0 (empty) to 4 (strong)
  int get strengthScore {
    if (password.isEmpty) return 0;
    int score = 0;
    if (password.length >= 6) score++;
    if (password.length >= 8 && RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password) ||
        (password.length >= 10 && RegExp(r'[a-zA-Z0-9]').hasMatch(password))) {
      score++;
    }
    return score.clamp(1, 4);
  }

  Color _getBarColor(int barIndex, int currentScore) {
    if (barIndex >= currentScore) {
      return const Color(0xFFE0E8E4); // Inactive segment color
    }
    switch (currentScore) {
      case 1:
        return const Color(0xFFE57373); // Red/coral for weak
      case 2:
        return const Color(0xFFFFB74D); // Warm amber for fair
      case 3:
        return const Color(0xFF81C784); // Light sage green for good
      case 4:
        return const Color(0xFF4C7B63); // Rich forest/emerald for strong
      default:
        return const Color(0xFFE0E8E4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final score = strengthScore;

    return Row(
      children: List.generate(4, (index) {
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            height: 4.5,
            margin: EdgeInsets.only(
              right: index < 3 ? 6.0 : 0.0,
            ),
            decoration: BoxDecoration(
              color: _getBarColor(index, score),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }
}
