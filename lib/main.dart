import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/feature/auth/view/login_screen.dart';
import 'package:e_commerce_app/feature/app_section/app_section.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view/register_screen.dart';
import 'package:e_commerce_app/feature/onboarding/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ecommerce App",
      initialRoute: RegisterScreen.routeName,
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => BlocProvider<RegisterCubit>(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterScreen()),
        AppSection.routeName: (context) => const AppSection(),
      },
    );
  }
}
