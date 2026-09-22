import 'package:e_commerce_app/feature/search/presentation/view/search_screen.dart';
import 'package:e_commerce_app/feature/search/presentation/view_model/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/core/routes/routes_names.dart';
import 'package:e_commerce_app/feature/app_section/app_section.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view/login_screen.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view_model/home_cubit/login_cubit.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view/register_screen.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_cubit.dart';
import 'package:e_commerce_app/feature/checkout/presentation/view/checkout_screen.dart';
import 'package:e_commerce_app/feature/details/presentation/view/product_details_screen.dart';
import 'package:e_commerce_app/feature/onboarding/onboarding_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.appSection,
    routes: [
      GoRoute(
        path: Routes.onboarding,
        name: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.search,
        name: Routes.search,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SearchCubit>(),
          child: const SearchScreen(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        name: Routes.register,
        builder: (context, state) => BlocProvider<RegisterCubit>(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: Routes.appSection,
        name: Routes.appSection,
        builder: (context, state) => const AppSection(),
      ),
      GoRoute(
        path: Routes.checkout,
        name: Routes.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: Routes.productDetails,
        name: Routes.productDetails,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
          return ProductDetailsScreen(productId: id);
        },
      ),
    ],
  );
}
