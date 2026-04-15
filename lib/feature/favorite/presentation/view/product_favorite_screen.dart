import 'package:e_commerce_app/feature/favorite/presentation/view/empty_favorite_screen.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view/non_empty_favorite_screen.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Favourite",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final cubit = context.read<FavoriteCubit>();

          if (cubit.favoritesList.isEmpty) {
            return const EmptyFavoriteScreen();
          } else {
            return const NonEmptyFavoriteScreen();
          }
        },
      ),
    );
  }
}
