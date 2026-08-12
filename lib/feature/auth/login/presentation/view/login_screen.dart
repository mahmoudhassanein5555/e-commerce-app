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
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/register_form_card.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/social_auth_divider.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/widgets/social_sign_in_buttons.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/reques_entites/register_request_entites.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_cubit.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  final AuthTab initialTab;

  const LoginScreen({
    super.key,
    this.initialTab = AuthTab.signIn,
  });

  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthTab _selectedTab;

  // Sign In Form Controllers
  late final GlobalKey<FormState> _loginFormKey;
  late final TextEditingController _loginEmailController;
  late final TextEditingController _loginPasswordController;

  // Sign Up Form Controllers
  late final GlobalKey<FormState> _registerFormKey;
  late final TextEditingController _regNameController;
  late final TextEditingController _regEmailController;
  late final TextEditingController _regPasswordController;
  late final TextEditingController _regConfirmPasswordController;
  bool _agreeToTerms = false;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;

    // Initialize Login form controllers
    _loginFormKey = GlobalKey<FormState>();
    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();

    // Initialize Register form controllers
    _registerFormKey = GlobalKey<FormState>();
    _regNameController = TextEditingController();
    _regEmailController = TextEditingController();
    _regPasswordController = TextEditingController();
    _regConfirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _regNameController.dispose();
    _regEmailController.dispose();
    _regPasswordController.dispose();
    _regConfirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_loginFormKey.currentState?.validate() ?? false) {
      await context.read<LoginCubit>().intent(
            LoginUser(
              email: _loginEmailController.text.trim(),
              password: _loginPasswordController.text,
            ),
          );
    }
  }

  Future<void> _handleRegister() async {
    if (_registerFormKey.currentState?.validate() ?? false) {
      if (!_agreeToTerms) {
        AppToast.showToast(
          context: context,
          title: "Terms Required",
          description: "Please agree to the Terms of Service & Privacy Policy to continue.",
          type: ToastificationType.warning,
        );
        return;
      }

      await context.read<RegisterCubit>().intent(
            RegisterUser(
              requist: RegisterRequestEntites(
                name: _regNameController.text.trim(),
                email: _regEmailController.text.trim(),
                password: _regPasswordController.text,
              ),
            ),
          );
    }
  }

  void _switchTab(AuthTab tab) {
    if (_selectedTab != tab) {
      setState(() {
        _selectedTab = tab;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          // Login State Listener
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                AppDialogs.showLoadingDialog(
                  context,
                  message: "Signing in...",
                );
              } else if (state is LoginSuccess) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppSection.routeName);
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
          ),

          // Register State Listener
          BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoading) {
                AppDialogs.showLoadingDialog(
                  context,
                  message: "Creating your account...",
                );
              } else if (state is RegisterSuccess) {
                Navigator.pop(context);
                AppToast.showToast(
                  context: context,
                  title: "Account Created",
                  description: "Welcome to SwiftBuy! Please sign in with your credentials.",
                  type: ToastificationType.success,
                );
                // Pre-fill login email with the newly registered email
                _loginEmailController.text = _regEmailController.text.trim();
                _regNameController.clear();
                _regEmailController.clear();
                _regPasswordController.clear();
                _regConfirmPasswordController.clear();
                setState(() {
                  _agreeToTerms = false;
                  _selectedTab = AuthTab.signIn;
                });
              } else if (state is RegisterError) {
                Navigator.pop(context);
                AppToast.showToast(
                  context: context,
                  title: "Registration Failed",
                  description: state.messageError,
                  type: ToastificationType.error,
                );
              }
            },
          ),
        ],
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
                      AuthTabSwitcher(
                        selectedTab: _selectedTab,
                        onTabChanged: _switchTab,
                      ),
                      const SizedBox(height: 20),

                      // Animated CrossFade between Sign In and Sign Up Forms
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstCurve: Curves.easeInOut,
                        secondCurve: Curves.easeInOut,
                        crossFadeState: _selectedTab == AuthTab.signIn
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: LoginFormCard(
                          formKey: _loginFormKey,
                          emailController: _loginEmailController,
                          passwordController: _loginPasswordController,
                          onLogin: _handleLogin,
                        ),
                        secondChild: RegisterFormCard(
                          formKey: _registerFormKey,
                          nameController: _regNameController,
                          emailController: _regEmailController,
                          passwordController: _regPasswordController,
                          confirmPasswordController: _regConfirmPasswordController,
                          agreeToTerms: _agreeToTerms,
                          onTermsChanged: (value) {
                            setState(() {
                              _agreeToTerms = value;
                            });
                          },
                          onRegister: _handleRegister,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Or Continue With Divider
                      const SocialAuthDivider(),
                      const SizedBox(height: 18),

                      // Apple & Google Sign-in Buttons
                      const SocialSignInButtons(),
                      const SizedBox(height: 24),

                      // Dynamic Footer Navigation Link
                      LoginFooterWidget(
                        selectedTab: _selectedTab,
                        onTabChanged: _switchTab,
                      ),
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
