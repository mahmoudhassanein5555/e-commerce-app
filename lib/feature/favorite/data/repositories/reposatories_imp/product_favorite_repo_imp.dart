import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';
import 'package:e_commerce_app/feature/favorite/domain/repositories/repo/product_favorite_repo.dart';
import 'package:e_commerce_app/feature/favorite/domain/repositories/data_source/product_favorite_data_source.dart';
import 'package:e_commerce_app/feature/favorite/data/models/product_favorite_model.dart';

class ProductFavoriteRepoImp implements ProductFavoriteRepo {
  final ProductFavoriteDataSource dataSource;

  ProductFavoriteRepoImp(this.dataSource);

  @override
  Future<void> addToFavorite(ProductFavoriteEntity product) async {
    final model = ProductFavoriteModel(
    
      title: product.title,
      image: product.image,
      price:  product.price.toString(),
    );

    await dataSource.addToFavorite(model);
  }

  @override
  Future<void> removeFromFavorite(int price) async {
    await dataSource.removeFromFavorite(price);
  }

  @override
  Future<List<ProductFavoriteEntity>> getFavorites() async {
    final models = await dataSource.getFavorites();

    return models.map((model) {
      return ProductFavoriteEntity(
        price: int.parse(model.price),
        title: model.title,
        image: model.image,
      );
    }).toList();
  }
}
