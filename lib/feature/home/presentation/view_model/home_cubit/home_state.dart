import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class GetCategoriesSuccess extends HomeState {
  GetCategoriesSuccess({required this.categories});
  final List<CategoriesResponseEntity> categories;
}

class GetProductsSuccess extends HomeState {
  GetProductsSuccess({required this.products});
  final List<ProductsResponseEntity> products;
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
