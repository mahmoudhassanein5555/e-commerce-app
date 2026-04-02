import 'package:e_commerce_app/feature/details/domain/entites/product_details_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class GetProductsDetailsSuccess extends ProductDetailsState {
  GetProductsDetailsSuccess({required this.productDetails});
  final ProductDetailsEntity productDetails;
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError({required this.message});
}
