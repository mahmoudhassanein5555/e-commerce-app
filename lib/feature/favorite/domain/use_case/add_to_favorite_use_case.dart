import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';
import 'package:e_commerce_app/feature/favorite/domain/repositories/repo/product_favorite_repo.dart';

class AddToFavoriteUseCase {
  final ProductFavoriteRepo repository;
  AddToFavoriteUseCase(this.repository);

  Future<void> call(ProductFavoriteEntity product) async {
    return await repository.addToFavorite(product);
  }
}
