import 'package:e_commerce_app/feature/cart/domain/entites/product_cart_entity.dart';

abstract class ProductCartRepo {
  Future<List<ProductCartEntity>> getCartItems();

  Future<void> addOrIncrementLine(ProductCartEntity line);

  Future<void> updateQuantity(int productId, int quantity);

  Future<void> removeFromCart(int productId);
}
