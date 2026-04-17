import 'package:e_commerce_app/feature/cart/domain/entites/product_cart_entity.dart';
import 'package:e_commerce_app/feature/cart/domain/repositories/repo/product_cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'product_cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  static const String fallbackImageUrl =
      'https://picperf.io/https://laravelnews.s3.amazonaws.com/featured-images/dummy.png';

  final ProductCartRepo _repo;

  CartCubit(this._repo) : super(const CartState()) {
    loadCart();
  }

  List<ProductCartEntity> get cartItems => state.items;

  Future<void> loadCart() async {
    final items = await _repo.getCartItems();
    items.sort((a, b) => a.title.compareTo(b.title));
    emit(CartState(items: items));
  }

  /// Adds one unit of a product (merges quantity if the product is already in the cart).
  Future<void> addProductLine({
    required int productId,
    required String title,
    required String imageUrl,
    required String price,
  }) async {
    await _repo.addOrIncrementLine(
      ProductCartEntity(
        id: productId,
        title: title,
        image: imageUrl,
        price: price,
        quantity: 1,
      ),
    );
    await loadCart();
  }

  Future<void> incrementQuantity(ProductCartEntity line) async {
    await _repo.updateQuantity(line.id, line.quantity + 1);
    await loadCart();
  }

  Future<void> decrementQuantity(ProductCartEntity line) async {
    if (line.quantity <= 1) {
      await removeLine(line.id);
      return;
    }
    await _repo.updateQuantity(line.id, line.quantity - 1);
    await loadCart();
  }

  Future<void> removeLine(int productId) async {
    await _repo.removeFromCart(productId);
    await loadCart();
  }
}
