import 'package:flutter/material.dart';

class LoginTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? action;
  final Widget? prefixIcon;
  final bool isPassword;

  const LoginTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.action,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.action ?? TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
        color: Color(0xFF16231E),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F8F6),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w400,
          color: Color(0xFF94A39D),
        ),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: widget.prefixIcon,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 46,
          minHeight: 24,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                splashRadius: 18,
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                  color: const Color(0xFF7A8B84),
                ),
                onPressed: _toggleVisibility,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE4EDE9),
            width: 1.2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE4EDE9),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF0C1613),
            width: 1.4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE53935),
            width: 1.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE53935),
            width: 1.4,
          ),
        ),
        errorStyle: const TextStyle(
          color: Color(0xFFE53935),
          fontSize: 12,
        ),
      ),
    );
  }
}
