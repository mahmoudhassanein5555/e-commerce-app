import 'dart:convert';

import 'package:e_commerce_app/core/constants/app_apis.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/search/data/data_source/search_data_source.dart';
import 'package:e_commerce_app/feature/search/data/models/search_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Injectable(as: SearchDataSource)
class SearchDataSourceImp implements SearchDataSource {
  @override
  Future<ResultApi<List<SearchModel>>> searchProducts(String query) async {
    try {
      final Uri url = Uri.https(
        AppApis.baseUrl,
        AppApis.products,
        {'title': query},
      );
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<SearchModel> products =
            jsonList.map<SearchModel>((e) => SearchModel.fromJson(e)).toList();
        return SuccessAPI<List<SearchModel>>(products);
      } else {
        return ErrorAPI<List<SearchModel>>(
          'Error From StatusCode Search Products',
        );
      }
    } catch (e) {
      return ErrorAPI<List<SearchModel>>(e.toString());
    }
  }
}
