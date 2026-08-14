import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoriesResponseEntity>>> getCategories();
  Future<Either<Failure, List<ProductsResponseEntity>>> getProducts(
      int categoryId);
}