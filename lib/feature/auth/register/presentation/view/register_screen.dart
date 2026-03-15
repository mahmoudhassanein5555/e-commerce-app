import 'package:e_commerce_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:e_commerce_app/core/dialogs/app_dialogs.dart';
import 'package:e_commerce_app/core/dialogs/app_toasts.dart';
import 'package:e_commerce_app/core/utils/validator_functions.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/reques_entites/register_request_entites.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_cubit.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_state.dart';
import 'package:e_commerce_app/feature/auth/view/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey;
  var emailController;
  var userNameController;
  var passwordController;
  var confirmPasswordController;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SignUp",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff1F1F1F),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pop(context);
            Navigator.pushNamed(context, LoginScreen.routeName);
          }
          if (state is RegisterError) {
            Navigator.pop(context);
            AppToast.showToast(
                context: context,
                title: "Error",
                description: state.messageError,
                type: ToastificationType.error);
          }
          if (state is RegisterLoading) {
            AppDialogs.showLoadingDialog(context);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "UserName",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: userNameController,
                  validator: Validator.validateName,
                  hintText: "Enter your username",
                  keyboardType: TextInputType.name,
                  action: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: emailController,
                  validator: Validator.validateEmail,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: passwordController,
                  validator: Validator.validatePassword,
                  hintText: "Enter your password",
                  isPassword: true,
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  validator: (value) => Validator.validateConfirmPassword(
                      value, passwordController.text),
                  hintText: "Enter your confirm password",
                  isPassword: true,
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.done,
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await context.read<RegisterCubit>().intent(RegisterUser(
                          requist: RegisterRequestEntites(
                              email: emailController.text,
                              name: userNameController.text,
                              password: passwordController.text)));
                      userNameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                    }
                  },
                  color: const Color(0xff212121),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff6E6A7C),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                    },
                  children: const [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
