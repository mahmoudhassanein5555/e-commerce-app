import 'package:e_commerce_app/core/utils/validator_functions.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/login_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback? onForgotPassword;

  const LoginFormCard({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 26.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2E25).withValues(alpha: 0.06),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // EMAIL OR USERNAME Label
            const Text(
              "EMAIL OR USERNAME",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF4C5D55),
              ),
            ),
            const SizedBox(height: 8),

            // Email Input Field
            LoginTextFormField(
              controller: emailController,
              validator: Validator.validateEmail,
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.mail_outline_rounded,
                color: Color(0xFF4C5D55),
                size: 20,
              ),
            ),
            const SizedBox(height: 18),

            // PASSWORD Label
            const Text(
              "PASSWORD",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF4C5D55),
              ),
            ),
            const SizedBox(height: 8),

            // Password Input Field
            LoginTextFormField(
              controller: passwordController,
              validator: Validator.validatePassword,
              hintText: "Enter your password",
              isPassword: true,
              action: TextInputAction.done,
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Color(0xFF4C5D55),
                size: 20,
              ),
            ),
            const SizedBox(height: 12),

            // Forgot Password Link
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onForgotPassword ?? () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFB88E3E),
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),

            // Sign In Action Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1613),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
