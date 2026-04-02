import 'dart:convert';

import 'package:e_commerce_app/core/constants/app_apis.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/details/data/models/product_details_dto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
@lazySingleton
class ProductDetailsApi {
  Future<ResultApi<ProductDetailsDto>> getProductDetails(int productId) async {
    try {
      Uri url =
          Uri.https(AppApis.baseUrl, AppApis.products + productId.toString());
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var json = jsonDecode(response.body);
        var dartProductDetails = ProductDetailsDto.fromJson(json);
        return SuccessAPI<ProductDetailsDto>(dartProductDetails);
      } else {
        return ErrorAPI<ProductDetailsDto>(
            "Error From StatusCode Get Product Details");
      }
    } catch (e) {
      return ErrorAPI<ProductDetailsDto>(e.toString());
    }
  }
}
