import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/repositories/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProdactsUseCase {
  GetProdactsUseCase(this._homeRepo);
  HomeRepo _homeRepo;
  Future<ResultApi<List<ProductsResponseEntity>>> invoke(int categoryId) async =>
      await _homeRepo.getProducts(categoryId);
}
