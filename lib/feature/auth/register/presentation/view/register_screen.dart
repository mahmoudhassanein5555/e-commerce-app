import 'package:e_commerce_app/feature/auth/login/presentation/view/login_screen.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/auth_tab_switcher.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  Widget build(BuildContext context) {
    return const LoginScreen(initialTab: AuthTab.signUp);
  }
}
