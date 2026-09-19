import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/search/domain/entities/search_entity.dart';
import 'package:e_commerce_app/feature/search/domain/use_cases/search_use_case.dart';
import 'package:e_commerce_app/feature/search/presentation/view_model/search_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase _searchUseCase;
  Timer? _debounceTimer;

  SearchCubit(this._searchUseCase) : super(SearchInitial());

  Future<void> intent(SearchIntent event) async {
    switch (event) {
      case SearchProducts(query: String query):
        search(query);
    }
  }

  void search(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (isClosed) return;
      emit(SearchLoading());
      final response = await _searchUseCase.invoke(query);
      if (isClosed) return;
      switch (response) {
        case SuccessAPI<List<SearchEntity>>():
          emit(SearchSuccess(products: response.data ?? []));
        case ErrorAPI<List<SearchEntity>>():
          emit(SearchError(message: response.messageError));
      }
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}

sealed class SearchIntent {}

class SearchProducts extends SearchIntent {
  final String query;
  SearchProducts({required this.query});
}
