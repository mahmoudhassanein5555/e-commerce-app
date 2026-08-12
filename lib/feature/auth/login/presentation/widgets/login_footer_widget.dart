import 'package:e_commerce_app/feature/auth/login/presentation/widgets/auth_tab_switcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginFooterWidget extends StatelessWidget {
  final AuthTab selectedTab;
  final ValueChanged<AuthTab> onTabChanged;

  const LoginFooterWidget({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSignIn = selectedTab == AuthTab.signIn;

    return Text.rich(
      TextSpan(
        text: isSignIn
            ? "Don't have an account? "
            : "Already have an account? ",
        style: const TextStyle(
          fontSize: 13.5,
          color: Color(0xFF5A6961),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: isSignIn ? "Sign Up" : "Log In",
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFFB88E3E),
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTabChanged(
                  isSignIn ? AuthTab.signUp : AuthTab.signIn,
                );
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
