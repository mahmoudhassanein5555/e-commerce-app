import '../../../data/models/product_favorite_model.dart';

abstract class ProductFavoriteDataSource {
  Future<void> addToFavorite(ProductFavoriteModel product);

  Future<void> removeFromFavorite(String title);

  Future<List<ProductFavoriteModel>> getFavorites();
}
