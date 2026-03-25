import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/get_categories_use_case.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/get_prodacts_use_case.dart';
import 'package:e_commerce_app/feature/home/presentation/view_model/home_cubit/home_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getCategoriesUseCase, this._getProdactsUseCase)
      : super(HomeInitial());
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProdactsUseCase _getProdactsUseCase;

  Future<void> intent(HomeIntent event) async {
    switch (event) {
      case GetCategories():
        await getCategories();
      case GetProducts(categoryId: int categoryId):
        await getProducts(categoryId);
      case LoadMainData(categoryId: int categoryId):
        await loadMainData(categoryId);
    }
  }

  Future<void> loadMainData(int categoryId) async {
    emit(HomeLoading());
    Future.wait([getCategories(), getProducts(categoryId)]);
  }

  Future<void> getCategories() async {
    var response = await _getCategoriesUseCase.invoke();
    switch (response) {
      case SuccessAPI<List<CategoriesResponseEntity>>():
        emit(GetCategoriesSuccess(categories: response.data!));
      case ErrorAPI<List<CategoriesResponseEntity>>():
        emit(HomeError(message: response.messageError));
    }
  }

  Future<void> getProducts(int categoryId) async {
    var response = await _getProdactsUseCase.invoke(categoryId);
    switch (response) {
      case SuccessAPI<List<ProductsResponseEntity>>():
        emit(GetProductsSuccess(products: response.data!));
      case ErrorAPI<List<ProductsResponseEntity>>():
        emit(HomeError(message: response.messageError));
    }
  }
}

sealed class HomeIntent {}

class GetCategories extends HomeIntent {}

class GetProducts extends HomeIntent {
  int categoryId;
  GetProducts({required this.categoryId});
}

class LoadMainData extends HomeIntent {
  int categoryId;
  LoadMainData({required this.categoryId});
}
