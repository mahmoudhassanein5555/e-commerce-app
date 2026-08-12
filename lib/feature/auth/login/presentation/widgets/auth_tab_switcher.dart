import 'package:flutter/material.dart';

enum AuthTab { signIn, signUp }

class AuthTabSwitcher extends StatelessWidget {
  final AuthTab selectedTab;
  final ValueChanged<AuthTab> onTabChanged;

  const AuthTabSwitcher({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSignIn = selectedTab == AuthTab.signIn;

    return Container(
      height: 50,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2E25).withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Sign In Tab
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onTabChanged(AuthTab.signIn),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSignIn ? const Color(0xFF0C1613) : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: isSignIn
                      ? [
                          BoxShadow(
                            color: const Color(0xFF0C1613).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: isSignIn ? Colors.white : const Color(0xFF5A6961),
                    fontSize: 14,
                    fontWeight: isSignIn ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),

          // Sign Up Tab
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onTabChanged(AuthTab.signUp),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: !isSignIn ? const Color(0xFF0C1613) : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: !isSignIn
                      ? [
                          BoxShadow(
                            color: const Color(0xFF0C1613).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: !isSignIn ? Colors.white : const Color(0xFF5A6961),
                    fontSize: 14,
                    fontWeight: !isSignIn ? FontWeight.w600 : FontWeight.w500,
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
