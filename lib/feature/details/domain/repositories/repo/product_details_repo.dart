import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/details/domain/entites/product_details_entity.dart';

abstract class ProductDetailsRepo {
  Future<ResultApi<ProductDetailsEntity>> getProductDetails(int productId);
}
