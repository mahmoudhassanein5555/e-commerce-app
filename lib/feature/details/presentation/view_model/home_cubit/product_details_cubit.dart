import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/details/domain/entites/product_details_entity.dart';
import 'package:e_commerce_app/feature/details/domain/use_case/get_product_details_use_case.dart';
import 'package:e_commerce_app/feature/details/presentation/view_model/home_cubit/product_details_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._getProductDetailsUseCase)
      : super(ProductDetailsInitial());
  final GetProductDetailsUseCase _getProductDetailsUseCase;
  Future<void> intent(ProductsDetailsIntent event) async {
    switch (event) {
      case GetProductDetails(productId: int productId):
        await getProductDetails(productId);
    }
  }

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    var response = await _getProductDetailsUseCase.invoke(productId);
    switch (response) {
      case SuccessAPI<ProductDetailsEntity>():
        emit(GetProductsDetailsSuccess(productDetails: response.data!));
      case ErrorAPI<ProductDetailsEntity>():
        emit(ProductDetailsError(message: response.messageError));
    }
  }
}

sealed class ProductsDetailsIntent {}

class GetProductDetails extends ProductsDetailsIntent {
  final int productId;
  GetProductDetails({required this.productId});
}
