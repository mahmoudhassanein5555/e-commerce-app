import 'package:flutter/material.dart';

class LoginBackgroundDecoration extends StatelessWidget {
  const LoginBackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Luxury Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF9F5EC), // Soft warm champagne/ivory
                Color(0xFFF3ECE0), // Warm beige
                Color(0xFFEAF1EB), // Subtle soft sage/mint
                Color(0xFFF6F2E9), // Light cream
              ],
              stops: [0.0, 0.35, 0.75, 1.0],
            ),
          ),
        ),

        // Concentric Rings Painter centered around top logo area
        Positioned.fill(
          child: CustomPaint(
            painter: _ConcentricRingsPainter(),
          ),
        ),

        // Floating Ambient Soft Orb 1 (Top Left)
        Positioned(
          top: 110,
          left: 20,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.45),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.6),
                  blurRadius: 20,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
        ),

        // Floating Ambient Soft Orb 2 (Middle Right)
        Positioned(
          top: 240,
          right: 25,
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.4),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 18,
                  spreadRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ConcentricRingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, 110);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final radii = [60.0, 110.0, 170.0, 240.0, 320.0, 410.0];

    for (int i = 0; i < radii.length; i++) {
      paint.color = const Color(0xFFD8CCB8)
          .withValues(alpha: (0.28 - (i * 0.035)).clamp(0.05, 0.25));
      canvas.drawCircle(center, radii[i], paint);
    }

    // Subtle curved organic lines
    final curvePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = const Color(0xFFD2C5B0).withValues(alpha: 0.18);

    final path = Path();
    path.moveTo(0, size.height * 0.35);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.42,
      size.width,
      size.height * 0.32,
    );
    canvas.drawPath(path, curvePaint);

    final path2 = Path();
    path2.moveTo(0, size.height * 0.78);
    path2.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.72,
      size.width,
      size.height * 0.82,
    );
    canvas.drawPath(path2, curvePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
