import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/error_handler.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/core/network/network_info.dart';
import 'package:e_commerce_app/feature/home/data/datasources/home_data_source.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/repositories/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeDataSource _homeDataSource;
  final NetworkInfo _networkInfo;

  HomeRepoImpl(this._homeDataSource, this._networkInfo);

  static const List<CategoriesResponseEntity> defaultCategories = [
    CategoriesResponseEntity(id: 1, name: 'All'),
    CategoriesResponseEntity(id: 2, name: 'Audio'),
    CategoriesResponseEntity(id: 3, name: 'Timepieces'),
    CategoriesResponseEntity(id: 4, name: 'Leather'),
    CategoriesResponseEntity(id: 5, name: 'Fragrance'),
  ];

  @override
  Future<Either<Failure, List<CategoriesResponseEntity>>>
      getCategories() async {
    if (!await _networkInfo.isConnected) {
      return Left(
          Failure("No internet connection. Please check your network."));
    }

    try {
      final categoryDtos = await _homeDataSource.getCategories();
      final categoryEntities = categoryDtos
          .map<CategoriesResponseEntity>((e) => e.toEntity())
          .toList();

      final listOfFilteredCategories =
          categoryEntities.where((e) => e.name.length > 6).toList();

      if (listOfFilteredCategories.isEmpty) {
        return const Right(defaultCategories);
      }

      final hasAll =
          listOfFilteredCategories.any((c) => c.name.toLowerCase() == 'all');
      final fullList = hasAll
          ? listOfFilteredCategories
          : [
              const CategoriesResponseEntity(id: 1, name: 'All'),
              ...listOfFilteredCategories,
            ];

      return Right(fullList);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductsResponseEntity>>> getProducts(
      int categoryId) async {
    if (!await _networkInfo.isConnected) {
      return Left(
          Failure("No internet connection. Please check your network."));
    }

    try {
      final productDtos = await _homeDataSource.getProducts(categoryId);
      final productEntities =
          productDtos.map<ProductsResponseEntity>((e) => e.toEntity()).toList();
      return Right(productEntities);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
