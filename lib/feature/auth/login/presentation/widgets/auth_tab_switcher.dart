import 'package:e_commerce_app/feature/auth/register/presentation/view/register_screen.dart';
import 'package:flutter/material.dart';

class AuthTabSwitcher extends StatelessWidget {
  final VoidCallback? onSignUpTap;

  const AuthTabSwitcher({
    super.key,
    this.onSignUpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Active Sign In Tab
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0C1613),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0C1613).withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),

          // Inactive Sign Up Tab
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onSignUpTap ??
                  () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Color(0xFF5A6961),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
