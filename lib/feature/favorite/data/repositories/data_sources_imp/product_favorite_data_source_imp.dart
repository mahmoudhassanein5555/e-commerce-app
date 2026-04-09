import 'package:e_commerce_app/feature/favorite/data/models/product_favorite_model.dart';
import 'package:e_commerce_app/feature/favorite/domain/repositories/data_source/product_favorite_data_source.dart';
import 'package:hive/hive.dart';

class ProductFavoriteDataSourceImp implements ProductFavoriteDataSource {
  static const String boxName = 'favorite_box';

  @override
  Future<void> addToFavorite(ProductFavoriteModel product) async {
    var box = await Hive.openBox<ProductFavoriteModel>(boxName);
    await box.put(product.price, product);
  }

  @override
  Future<void> removeFromFavorite(int price) async {
    var box = await Hive.openBox<ProductFavoriteModel>(boxName);
    await box.delete(price);
  }

  @override
  Future<List<ProductFavoriteModel>> getFavorites() async {
    var box = await Hive.openBox<ProductFavoriteModel>(boxName);
    return box.values.toList();
  }
}
