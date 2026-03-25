import 'dart:convert';

import 'package:e_commerce_app/core/constants/app_apis.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/home/data/models/get_categories_response.dart';
import 'package:e_commerce_app/feature/home/data/models/products_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
@lazySingleton
class HomeApi {
  Future<ResultApi<List<CategoriesResponseDto>>> getCategories() async {
    try {
      Uri url = Uri.https(AppApis.baseUrl, AppApis.categories);
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> jsonList = jsonDecode(response.body);
        var listCategories = jsonList
            .map<CategoriesResponseDto>(
              (e) => CategoriesResponseDto.fromJson(e),
            )
            .toList();
        return SuccessAPI<List<CategoriesResponseDto>>(listCategories);
      } else {
        return ErrorAPI<List<CategoriesResponseDto>>(
          "Error From StatusCode Get Categories",
        );
      }
    } catch (e) {
      return ErrorAPI<List<CategoriesResponseDto>>(e.toString());
    }
  }

  Future<ResultApi<List<ProductsResponseDto>>> getProducts(
      int categoryId) async {
    try {
      Uri url = Uri.https(AppApis.baseUrl,
          "${AppApis.categories}$categoryId${AppApis.getProducts}");
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> jsonList = jsonDecode(response.body);
        var listProducts = jsonList
            .map<ProductsResponseDto>((e) => ProductsResponseDto.fromJson(e))
            .toList();
        return SuccessAPI<List<ProductsResponseDto>>(listProducts);
      } else {
        return ErrorAPI<List<ProductsResponseDto>>(
          "Error From StatusCode Get Products",
        );
      }
    } catch (e) {
      return ErrorAPI<List<ProductsResponseDto>>(e.toString());
    }
  }
}
