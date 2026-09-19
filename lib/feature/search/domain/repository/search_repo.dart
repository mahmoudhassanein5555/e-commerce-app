import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/search/domain/entities/search_entity.dart';

abstract class SearchRepo {
  Future<ResultApi<List<SearchEntity>>> searchProducts(String query);
}
