import 'package:e_commerce_app/core/utils/validator_functions.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/login_text_form_field.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/password_strength_indicator.dart';
import 'package:flutter/material.dart';

class RegisterFormCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool agreeToTerms;
  final ValueChanged<bool> onTermsChanged;
  final VoidCallback onRegister;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  const RegisterFormCard({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.agreeToTerms,
    required this.onTermsChanged,
    required this.onRegister,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  @override
  State<RegisterFormCard> createState() => _RegisterFormCardState();
}

class _RegisterFormCardState extends State<RegisterFormCard> {
  String _currentPassword = "";

  @override
  void initState() {
    super.initState();
    _currentPassword = widget.passwordController.text;
    widget.passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    widget.passwordController.removeListener(_onPasswordChanged);
    super.dispose();
  }

  void _onPasswordChanged() {
    if (mounted && _currentPassword != widget.passwordController.text) {
      setState(() {
        _currentPassword = widget.passwordController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
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
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // FULL NAME Label
            const Text(
              "FULL NAME",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF4C5D55),
              ),
            ),
            const SizedBox(height: 8),

            // Full Name Field
            LoginTextFormField(
              controller: widget.nameController,
              validator: Validator.validateName,
              hintText: "Elise Aumont",
              keyboardType: TextInputType.name,
              action: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.person_outline_rounded,
                color: Color(0xFF4C5D55),
                size: 20,
              ),
            ),
            const SizedBox(height: 18),

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

            // Email Field
            LoginTextFormField(
              controller: widget.emailController,
              validator: Validator.validateEmail,
              hintText: "you@swiftbuy.com",
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

            // Password Field
            LoginTextFormField(
              controller: widget.passwordController,
              validator: Validator.validatePassword,
              hintText: "••••••••",
              isPassword: true,
              action: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Color(0xFF4C5D55),
                size: 20,
              ),
            ),
            const SizedBox(height: 14),

            // STRENGTH Label
            const Text(
              "STRENGTH",
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF4C5D55),
              ),
            ),
            const SizedBox(height: 8),

            // Password Strength Indicator
            PasswordStrengthIndicator(password: _currentPassword),
            const SizedBox(height: 18),

            // CONFIRM PASSWORD Label
            const Text(
              "CONFIRM PASSWORD",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF4C5D55),
              ),
            ),
            const SizedBox(height: 8),

            // Confirm Password Field
            LoginTextFormField(
              controller: widget.confirmPasswordController,
              validator: (val) => Validator.validateConfirmPassword(
                val,
                widget.passwordController.text,
              ),
              hintText: "••••••••",
              isPassword: true,
              action: TextInputAction.done,
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Color(0xFF4C5D55),
                size: 20,
              ),
            ),
            const SizedBox(height: 18),

            // Terms and Privacy Policy Agreement
            GestureDetector(
              onTap: () {
                widget.onTermsChanged(!widget.agreeToTerms);
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circular Checkbox
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.agreeToTerms
                          ? const Color(0xFF0C1613)
                          : Colors.transparent,
                      border: Border.all(
                        color: widget.agreeToTerms
                            ? const Color(0xFF0C1613)
                            : const Color(0xFFBAC7C1),
                        width: 1.5,
                      ),
                    ),
                    child: widget.agreeToTerms
                        ? const Icon(
                            Icons.check,
                            size: 13,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 10),

                  // Terms text
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "I agree to SwiftBuy's ",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4C5D55),
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: GestureDetector(
                              onTap: widget.onTermsTap ?? () {},
                              child: const Text(
                                "Terms of Service",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFB88E3E),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: " and "),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: GestureDetector(
                              onTap: widget.onPrivacyTap ?? () {},
                              child: const Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFB88E3E),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: "."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Create Account Action Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: widget.onRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B7B73),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text(
                  "Create Account",
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
