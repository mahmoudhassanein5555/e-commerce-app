import 'package:e_commerce_app/feature/favorite/domain/repositories/repo/product_favorite_repo.dart';

class RemoveFromFavoriteUseCase {
  final ProductFavoriteRepo repository;
  RemoveFromFavoriteUseCase(this.repository);

  Future<void> call(String title) async {
    return await repository.removeFromFavorite(title);
  }
}
