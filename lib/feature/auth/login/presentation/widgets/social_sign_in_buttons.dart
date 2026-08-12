import 'dart:math' as math;
import 'package:flutter/material.dart';

class SocialSignInButtons extends StatelessWidget {
  final VoidCallback? onApplePressed;
  final VoidCallback? onGooglePressed;

  const SocialSignInButtons({
    super.key,
    this.onApplePressed,
    this.onGooglePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Apple Sign In Button
        Expanded(
          child: AppleSignInButton(
            onPressed: onApplePressed ?? () {},
          ),
        ),
        const SizedBox(width: 14),

        // Google Sign In Button
        Expanded(
          child: GoogleSignInButton(
            onPressed: onGooglePressed ?? () {},
          ),
        ),
      ],
    );
  }
}

class AppleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppleSignInButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: const Color(0xFFE5DAC7),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.apple,
              size: 22,
              color: Color(0xFF16231E),
            ),
            SizedBox(width: 8),
            Text(
              "Apple",
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF16231E),
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: const Color(0xFFE5DAC7),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleLogoWidget(size: 19),
            SizedBox(width: 8),
            Text(
              "Google",
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF16231E),
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A crisp custom-painted Google "G" logo
class GoogleLogoWidget extends StatelessWidget {
  final double size;

  const GoogleLogoWidget({
    super.key,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w / 2;
    final strokeW = w * 0.22;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.butt;

    final rect = Rect.fromCircle(center: center, radius: radius - strokeW / 2);

    // Red: Top arc (from -45 to -135 deg approx)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, -math.pi * 0.75, math.pi * 0.55, false, paint);

    // Yellow: Left arc
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, -math.pi * 0.20 - math.pi, math.pi * 0.45, false, paint);

    // Green: Bottom arc
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, math.pi * 0.25, math.pi * 0.50, false, paint);

    // Blue: Right arc
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, -math.pi * 0.20, math.pi * 0.45, false, paint);

    // Blue horizontal middle bar
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final barRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        center.dx - strokeW * 0.1,
        center.dy - strokeW / 2,
        radius * 1.05,
        strokeW,
      ),
      Radius.circular(strokeW * 0.1),
    );
    canvas.drawRRect(barRect, barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
