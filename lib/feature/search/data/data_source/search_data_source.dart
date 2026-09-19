import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/search/data/models/search_model.dart';

abstract class SearchDataSource {
  Future<ResultApi<List<SearchModel>>> searchProducts(String query);
}
