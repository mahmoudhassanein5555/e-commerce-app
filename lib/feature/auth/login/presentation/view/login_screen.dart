import 'package:e_commerce_app/core/dialogs/app_dialogs.dart';
import 'package:e_commerce_app/core/dialogs/app_toasts.dart';
import 'package:e_commerce_app/feature/app_section/app_section.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view_model/home_cubit/login_cubit.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view_model/home_cubit/login_state.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/auth_tab_switcher.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/login_background_decoration.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/login_footer_widget.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/login_form_card.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/login_header_widget.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/social_auth_divider.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/social_sign_in_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      await context.read<LoginCubit>().intent(
            LoginUser(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            AppDialogs.showLoadingDialog(context);
          } else if (state is LoginSuccess) {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppSection.routeName);
          } else if (state is LoginError) {
            Navigator.pop(context);
            AppToast.showToast(
              context: context,
              title: "Error",
              description: state.message,
              type: ToastificationType.error,
            );
          }
        },
        child: Stack(
          children: [
            // Background Decoration Layer
            const Positioned.fill(
              child: LoginBackgroundDecoration(),
            ),

            // Foreground Scrollable Content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),

                      // Brand Header
                      const LoginHeaderWidget(),
                      const SizedBox(height: 24),

                      // Sign In / Sign Up Tab Switcher
                      const AuthTabSwitcher(),
                      const SizedBox(height: 20),

                      // Form Input Card
                      LoginFormCard(
                        formKey: _formKey,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        onLogin: _handleLogin,
                      ),
                      const SizedBox(height: 24),

                      // Or Continue With Divider
                      const SocialAuthDivider(),
                      const SizedBox(height: 18),

                      // Apple & Google Sign-in Buttons (UI Only)
                      const SocialSignInButtons(),
                      const SizedBox(height: 24),

                      // Footer Navigation Link
                      const LoginFooterWidget(),
                      const SizedBox(height: 12),
                    ],
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
