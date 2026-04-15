import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/favorite_item_widget.dart';

class NonEmptyFavoriteScreen extends StatelessWidget {
  const NonEmptyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final favorites = context.read<FavoriteCubit>().favoritesList;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.58,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return FavoriteItemWidget(product: favorites[index]);
          },
        );
      },
    );
  }
}
