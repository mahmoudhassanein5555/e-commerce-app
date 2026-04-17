import 'package:e_commerce_app/feature/cart/data/models/product_cart_model.dart';
import 'package:e_commerce_app/feature/cart/domain/entites/product_cart_entity.dart';
import 'package:e_commerce_app/feature/cart/domain/repositories/data_source/product_cart_data_source.dart';
import 'package:e_commerce_app/feature/cart/domain/repositories/repo/product_cart_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductCartRepo)
class ProductCartRepoImp implements ProductCartRepo {
  final ProductCartDataSource dataSource;

  ProductCartRepoImp(this.dataSource);

  ProductCartModel _toModel(ProductCartEntity e) {
    return ProductCartModel(
      id: e.id,
      title: e.title,
      image: e.image,
      price: e.price,
      quantity: e.quantity,
    );
  }

  ProductCartEntity _toEntity(ProductCartModel m) {
    return ProductCartEntity(
      id: m.id,
      title: m.title,
      image: m.image,
      price: m.price,
      quantity: m.quantity,
    );
  }

  @override
  Future<List<ProductCartEntity>> getCartItems() async {
    final models = await dataSource.getLines();
    return models.map(_toEntity).toList();
  }

  @override
  Future<void> addOrIncrementLine(ProductCartEntity line) async {
    final models = await dataSource.getLines();
    final index = models.indexWhere((m) => m.id == line.id);
    if (index >= 0) {
      final existing = models[index];
      final merged = ProductCartModel(
        id: line.id,
        title: line.title,
        image: line.image,
        price: line.price,
        quantity: existing.quantity + line.quantity,
      );
      await dataSource.putLine(merged);
    } else {
      await dataSource.putLine(_toModel(line));
    }
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      await dataSource.deleteLine(productId);
      return;
    }
    final models = await dataSource.getLines();
    final index = models.indexWhere((m) => m.id == productId);
    if (index < 0) return;
    final existing = models[index];
    await dataSource.putLine(
      ProductCartModel(
        id: existing.id,
        title: existing.title,
        image: existing.image,
        price: existing.price,
        quantity: quantity,
      ),
    );
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await dataSource.deleteLine(productId);
  }
}
