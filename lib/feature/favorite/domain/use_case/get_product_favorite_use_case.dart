import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';
import 'package:e_commerce_app/feature/favorite/domain/repositories/repo/product_favorite_repo.dart';

class GetFavoritesUseCase {
  final ProductFavoriteRepo repository;

  GetFavoritesUseCase(this.repository);

  Future<List<ProductFavoriteEntity>> call() async {
    return await repository.getFavorites();
  }
}
