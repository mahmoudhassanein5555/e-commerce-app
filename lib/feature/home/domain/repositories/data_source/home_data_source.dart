import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';

abstract class HomeDataSource {
  Future<ResultApi<List<CategoriesResponseEntity>>> getCategories();
  Future<ResultApi<List<ProductsResponseEntity>>> getProdacts(int categoryId);
}
