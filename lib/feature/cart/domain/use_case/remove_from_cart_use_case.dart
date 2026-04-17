import 'package:e_commerce_app/feature/cart/domain/repositories/repo/product_cart_repo.dart';

class RemoveFromCartUseCase {
  final ProductCartRepo repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(int productId) {
    return repository.removeFromCart(productId);
  }
}
