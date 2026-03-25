import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/repositories/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  GetCategoriesUseCase(this._homeRepo);
  HomeRepo _homeRepo;
  Future<ResultApi<List<CategoriesResponseEntity>>> invoke() {
    return _homeRepo.getCategories();
  }
}
