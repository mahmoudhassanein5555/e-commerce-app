import 'package:e_commerce_app/feature/cart/domain/entites/product_cart_entity.dart';
import 'package:e_commerce_app/feature/cart/domain/repositories/repo/product_cart_repo.dart';

class GetProductCartUseCase {
  final ProductCartRepo repository;

  GetProductCartUseCase(this.repository);

  Future<List<ProductCartEntity>> call() {
    return repository.getCartItems();
  }
}
