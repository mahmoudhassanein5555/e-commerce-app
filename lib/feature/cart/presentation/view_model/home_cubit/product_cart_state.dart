import 'package:e_commerce_app/feature/cart/domain/entites/product_cart_entity.dart';

class CartState {
  final List<ProductCartEntity> items;

  const CartState({this.items = const []});

  int get totalQuantity =>
      items.fold(0, (sum, element) => sum + element.quantity);
}
