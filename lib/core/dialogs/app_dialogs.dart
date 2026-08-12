import 'dart:ui';
import 'package:flutter/material.dart';

abstract class AppDialogs {
  /// Displays a luxury SwiftBuy loading dialog with glassmorphic blur and brand styling
  static void showLoadingDialog(
    BuildContext context, {
    String message = "Please wait...",
    String? subtitle = "S W I F T B U Y",
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0xFF0C1613).withValues(alpha: 0.40),
      builder: (context) {
        return PopScope(
          canPop: false,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC59B27).withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: const Color(0xFF0C1613).withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated Brand Loading Badge with Ring
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer smooth gold spinner ring
                        const SizedBox(
                          width: 64,
                          height: 64,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.8,
                            strokeCap: StrokeCap.round,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFFB88E3E), // SwiftBuy Gold
                            ),
                          ),
                        ),
                        // Inner luxury SB monogram badge
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF0C1613),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0C1613).withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "SB",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'serif',
                                color: Color(0xFFE5DAC7),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Brand Subtitle
                    if (subtitle != null) ...[
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3.5,
                          color: Color(0xFFB88E3E),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],

                    // Loading Status Message
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF16231E),
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
