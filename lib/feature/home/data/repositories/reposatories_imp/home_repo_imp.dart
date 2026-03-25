import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/repositories/data_source/home_data_source.dart';
import 'package:e_commerce_app/feature/home/domain/repositories/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  HomeRepoImp(this._homeDataSource);
  HomeDataSource _homeDataSource;
  @override
  Future<ResultApi<List<CategoriesResponseEntity>>> getCategories() async =>
      await _homeDataSource.getCategories();

  @override
  Future<ResultApi<List<ProductsResponseEntity>>> getProducts(int categoryId) async =>
      await _homeDataSource.getProdacts(categoryId);
}
