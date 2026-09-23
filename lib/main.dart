import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/feature/app_section/main_tab_cubit.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_cubit.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_cubit.dart';
import 'package:e_commerce_app/feature/favorite/data/models/product_favorite_model.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive.registerAdapter(
    ProductFavoriteModelAdapter() as TypeAdapter<dynamic>,
  );

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<MainTabCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<RegisterCubit>(),
            ),
            BlocProvider(
              create: (context) {
                final cubit = getIt<FavoriteCubit>();
                cubit.getFavorites();
                return cubit;
              },
            ),
            BlocProvider(
              create: (context) => getIt<CartCubit>(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
