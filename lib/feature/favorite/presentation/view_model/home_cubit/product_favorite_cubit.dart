import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';
import 'package:e_commerce_app/feature/favorite/domain/repositories/repo/product_favorite_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final ProductFavoriteRepo repo;

  List<ProductFavoriteEntity> favoritesList = [];

  FavoriteCubit(this.repo) : super(FavoriteInitial());

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      favoritesList = await repo.getFavorites();
      emit(FavoriteSuccess(List.from(favoritesList)));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> toggleFavorite(ProductFavoriteEntity product) async {
    bool isExist =
        favoritesList.any((element) => element.title == product.title);

    try {
      if (isExist) {
        await repo.removeFromFavorite(product.title.hashCode);
        favoritesList.removeWhere((element) => element.title == product.title);
      } else {
        await repo.addToFavorite(product);
        favoritesList.add(product);
      }

      emit(FavoriteSuccess(List.from(favoritesList)));
    } catch (e) {
      emit(FavoriteError("عطل في تحديث المفضلة"));
    }
  }

  Future<void> removeItem(String title) async {
    try {
      await repo.removeFromFavorite(title.hashCode);
      favoritesList.removeWhere((element) => element.title == title);
      emit(FavoriteSuccess(List.from(favoritesList)));
    } catch (e) {
      emit(
          FavoriteError("Error removing item from favorites: ${e.toString()}"));
    }
  }
}
