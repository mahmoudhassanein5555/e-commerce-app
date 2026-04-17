import 'package:e_commerce_app/feature/auth/login/presentation/view_model/home_cubit/login_cubit.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view/login_screen.dart';
import 'package:e_commerce_app/feature/app_section/app_section.dart';
import 'package:e_commerce_app/feature/app_section/main_tab_cubit.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view/register_screen.dart';
import 'package:e_commerce_app/feature/favorite/data/models/product_favorite_model.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:e_commerce_app/feature/onboarding/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_commerce_app/feature/cart/data/models/product_cart_model.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_cubit.dart';
import 'package:e_commerce_app/feature/checkout/presentation/view/checkout_screen.dart';

// Hive favorites: the on-disk box file is only created after Hive.initFlutter() runs and the
// ProductFavoriteModel TypeAdapter is registered (see generated product_favorite_model.g.dart).
// Without those steps, openBox<ProductFavoriteModel> fails or never persists. If the .g.dart file
// is missing, run from project root:
//   flutter pub run build_runner build --delete-conflicting-outputs --force-aot

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductFavoriteModelAdapter());
  Hive.registerAdapter(ProductCartModelAdapter());
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MainTabCubit>()),
        BlocProvider(create: (context) => getIt<RegisterCubit>()),
        BlocProvider(
          create: (context) {
            final cubit = getIt<FavoriteCubit>();
            cubit.getFavorites();
            return cubit;
          },
        ),
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Ecommerce App",
        // initialRoute: RegisterScreen.routeName,
        initialRoute: AppSection.routeName,
        routes: {
          OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          LoginScreen.routeName: (context) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: const LoginScreen(),
              ),
          RegisterScreen.routeName: (context) => BlocProvider<RegisterCubit>(
              create: (context) => getIt<RegisterCubit>(),
              child: const RegisterScreen()),
          AppSection.routeName: (context) => const AppSection(),
          CheckoutScreen.routeName: (context) => const CheckoutScreen(),
        },
      ),
    );
  }
}
