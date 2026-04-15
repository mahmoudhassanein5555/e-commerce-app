import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';
import 'package:e_commerce_app/feature/favorite/domain/repositories/repo/product_favorite_repo.dart';
import 'package:e_commerce_app/feature/favorite/domain/repositories/data_source/product_favorite_data_source.dart';
import 'package:e_commerce_app/feature/favorite/data/models/product_favorite_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductFavoriteRepo)
class ProductFavoriteRepoImp implements ProductFavoriteRepo {
  final ProductFavoriteDataSource dataSource;

  ProductFavoriteRepoImp(this.dataSource);

  @override
  Future<void> addToFavorite(ProductFavoriteEntity product) async {
    final model = ProductFavoriteModel(
      title: product.title,
      image: product.image,
      price: product.price.toString(),
      productId: product.productId,
    );

    await dataSource.addToFavorite(model);
  }

  @override
  Future<void> removeFromFavorite(String title) async {
    await dataSource.removeFromFavorite(title);
  }

  @override
  Future<List<ProductFavoriteEntity>> getFavorites() async {
    final models = await dataSource.getFavorites();

    return models.map((model) {
      return ProductFavoriteEntity(
        price: model.price,
        title: model.title,
        image: model.image,
        productId: model.productId,
      );
    }).toList();
  }
}
