import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/home/data/api/home_api.dart';
import 'package:e_commerce_app/feature/home/data/models/get_categories_response.dart';
import 'package:e_commerce_app/feature/home/data/models/products_response_dto.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/repositories/data_source/home_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImp implements HomeDataSource {
  HomeDataSourceImp(this._homeApi);
  HomeApi _homeApi;
  @override
  Future<ResultApi<List<CategoriesResponseEntity>>> getCategories() async {
    var result = await _homeApi.getCategories();
    switch (result) {
      case SuccessAPI<List<CategoriesResponseDto>>():
        final listCategoryDto = result.data;
        final listCategoryEntity = listCategoryDto
            ?.map<CategoriesResponseEntity>((e) => e.toEntity())
            .toList();
        final listOfFilteredCategories = listCategoryEntity
            ?.where((e) => e.name.length > 6)
            .toList(); //not real

        return SuccessAPI<List<CategoriesResponseEntity>>(
            listOfFilteredCategories);
      case ErrorAPI<List<CategoriesResponseDto>>():
        return ErrorAPI<List<CategoriesResponseEntity>>(result.messageError);
    }
  }

  @override
  Future<ResultApi<List<ProductsResponseEntity>>> getProdacts(
      int categoryId) async {
    var result = await _homeApi.getProducts(categoryId);
    switch (result) {
      case SuccessAPI<List<ProductsResponseDto>>():
        var listProductsDto = result.data;
        var listProductsEntity = listProductsDto
            ?.map<ProductsResponseEntity>((e) => e.toEntity())
            .toList();
        return SuccessAPI<List<ProductsResponseEntity>>(listProductsEntity);
      case ErrorAPI<List<ProductsResponseDto>>():
        return ErrorAPI<List<ProductsResponseEntity>>(result.messageError);
    }
  }
}
