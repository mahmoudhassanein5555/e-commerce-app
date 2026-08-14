import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_endpoints.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/feature/home/data/datasources/home_data_source.dart';
import 'package:e_commerce_app/feature/home/data/models/categories_response_dto.dart';
import 'package:e_commerce_app/feature/home/data/models/products_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final ApiManager _apiManager;

  HomeDataSourceImpl(this._apiManager);

  @override
  Future<List<CategoriesResponseDto>> getCategories() async {
    final Response response = await _apiManager.getData(
      endPoint: ApiEndpoints.categories,
    );

    final dynamic data = response.data;
    final List<dynamic> jsonList = data is List
        ? data
        : (data is String ? jsonDecode(data) as List<dynamic> : <dynamic>[]);

    return jsonList
        .map((json) =>
            CategoriesResponseDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ProductsResponseDto>> getProducts(int categoryId) async {
    final Response response = await _apiManager.getData(
      endPoint:
          '${ApiEndpoints.categories}/$categoryId/${ApiEndpoints.products}',
    );

    final dynamic data = response.data;
    final List<dynamic> jsonList = data is List
        ? data
        : (data is String ? jsonDecode(data) as List<dynamic> : <dynamic>[]);

    return jsonList
        .map((json) =>
            ProductsResponseDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
