import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/search/data/data_source/search_data_source.dart';
import 'package:e_commerce_app/feature/search/data/models/search_model.dart';
import 'package:e_commerce_app/feature/search/domain/entities/search_entity.dart';
import 'package:e_commerce_app/feature/search/domain/repository/search_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRepo)
class SearchRepoImp implements SearchRepo {
  final SearchDataSource _searchDataSource;

  SearchRepoImp(this._searchDataSource);

  @override
  Future<ResultApi<List<SearchEntity>>> searchProducts(String query) async {
    final result = await _searchDataSource.searchProducts(query);
    switch (result) {
      case SuccessAPI<List<SearchModel>>():
        return SuccessAPI<List<SearchEntity>>(result.data);
      case ErrorAPI<List<SearchModel>>():
        return ErrorAPI<List<SearchEntity>>(result.messageError);
    }
  }
}
