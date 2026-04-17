import 'package:e_commerce_app/feature/cart/domain/entites/product_cart_entity.dart';
import 'package:e_commerce_app/feature/cart/domain/repositories/repo/product_cart_repo.dart';

class AddToCartUseCase {
  final ProductCartRepo repository;

  AddToCartUseCase(this.repository);

  Future<void> call(ProductCartEntity line) {
    return repository.addOrIncrementLine(line);
  }
}
