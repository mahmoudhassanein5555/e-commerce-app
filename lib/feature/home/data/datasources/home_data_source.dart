import '../models/categories_response_dto.dart';
import '../models/products_response_dto.dart';

abstract class HomeDataSource {
  Future<List<CategoriesResponseDto>> getCategories();
  Future<List<ProductsResponseDto>> getProducts(int categoryId);
}
