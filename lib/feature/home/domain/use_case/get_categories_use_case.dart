import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/repositories/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  GetCategoriesUseCase(this._homeRepo);
  final HomeRepo _homeRepo;
  Future<Either<Failure, List<CategoriesResponseEntity>>> invoke() {
    return _homeRepo.getCategories();
  }
}
