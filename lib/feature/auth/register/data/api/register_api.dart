import 'dart:convert';
import 'package:e_commerce_app/core/constants/app_apis.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/register/data/models/request/register_request_dto.dart';
import 'package:e_commerce_app/feature/auth/register/data/models/response/register_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class RegisterApi {
  Future<ResultApi<RegisterResponseDto>> register(
      RegisterRequestDto request) async {
    try {
      Uri url = Uri.https(AppApis.baseUrl, AppApis.register);
      var response = await http.post(url, body: request.toJson());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var responseBody = response.body;
        var json = jsonDecode(responseBody);
        return SuccessAPI<RegisterResponseDto>(
            RegisterResponseDto.fromJson(json));
      } else {
        return ErrorAPI<RegisterResponseDto>(response.body);
      }
    } catch (e) {
      return ErrorAPI<RegisterResponseDto>(e.toString());
    }
  }
}
