import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';

abstract class ProductFavoriteRepo {
  Future<void> addToFavorite(ProductFavoriteEntity product);

  Future<void> removeFromFavorite(String title);

  Future<List<ProductFavoriteEntity>> getFavorites();
}
