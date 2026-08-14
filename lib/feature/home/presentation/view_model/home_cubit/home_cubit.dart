import 'package:bloc/bloc.dart';
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
    await Future.wait([getCategories(), getProducts(categoryId)]);
  }

  Future<void> getCategories() async {
    final response = await _getCategoriesUseCase.invoke();
    response.fold(
      (failure) => emit(HomeError(message: failure.failuremessage)),
      (categories) => emit(GetCategoriesSuccess(categories: categories)),
    );
  }

  Future<void> getProducts(int categoryId) async {
    final response = await _getProdactsUseCase.invoke(categoryId);
    response.fold(
      (failure) => emit(HomeError(message: failure.failuremessage)),
      (products) => emit(GetProductsSuccess(products: products)),
    );
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
