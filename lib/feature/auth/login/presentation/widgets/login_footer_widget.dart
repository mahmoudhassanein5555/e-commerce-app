import 'package:e_commerce_app/feature/auth/register/presentation/view/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginFooterWidget extends StatelessWidget {
  final VoidCallback? onSignUpTap;

  const LoginFooterWidget({
    super.key,
    this.onSignUpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Don't have an account? ",
        style: const TextStyle(
          fontSize: 13.5,
          color: Color(0xFF5A6961),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: "Sign Up",
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFFB88E3E),
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onSignUpTap ??
                  () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
