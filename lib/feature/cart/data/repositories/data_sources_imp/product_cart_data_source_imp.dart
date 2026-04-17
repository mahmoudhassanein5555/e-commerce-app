import 'package:e_commerce_app/feature/cart/data/models/product_cart_model.dart';
import 'package:e_commerce_app/feature/cart/domain/repositories/data_source/product_cart_data_source.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductCartDataSource)
class ProductCartDataSourceImp implements ProductCartDataSource {
  static const String boxName = 'cart_box';

  @override
  Future<void> putLine(ProductCartModel model) async {
    final box = await Hive.openBox<ProductCartModel>(boxName);
    await box.put(model.id.toString(), model);
  }

  @override
  Future<void> deleteLine(int productId) async {
    final box = await Hive.openBox<ProductCartModel>(boxName);
    await box.delete(productId.toString());
  }

  @override
  Future<List<ProductCartModel>> getLines() async {
    final box = await Hive.openBox<ProductCartModel>(boxName);
    return box.values.toList();
  }
}
