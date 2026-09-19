import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/search/domain/entities/search_entity.dart';
import 'package:e_commerce_app/feature/search/domain/repository/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchUseCase {
  final SearchRepo _searchRepo;

  SearchUseCase(this._searchRepo);

  Future<ResultApi<List<SearchEntity>>> invoke(String query) async =>
      await _searchRepo.searchProducts(query);
}
