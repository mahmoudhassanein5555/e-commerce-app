import 'package:e_commerce_app/feature/favorite/presentation/view/empty_favorite_screen.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view/non_empty_favorite_screen.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: InkWell(
            onTap: () => context.pop(),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16),
            ),
          ),
        ),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              "SAVED",
              style: TextStyle(
                color: Color(0xFFC59A55),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              "Your wishlist",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE5F8E6),
              Color(0xFFFEF6E4),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              final cubit = context.read<FavoriteCubit>();

              if (cubit.favoritesList.isEmpty) {
                return const EmptyFavoriteScreen();
              } else {
                return const NonEmptyFavoriteScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
