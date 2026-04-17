import '../../../data/models/product_cart_model.dart';

abstract class ProductCartDataSource {
  Future<void> putLine(ProductCartModel model);

  Future<void> deleteLine(int productId);

  Future<List<ProductCartModel>> getLines();
}
