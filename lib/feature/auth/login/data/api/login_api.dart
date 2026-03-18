import 'dart:convert';

import 'package:e_commerce_app/core/constants/app_apis.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/data/models/response/login_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class LoginApi {
  Future<ResultApi<LoginResponseDto>> login(
      String email, String password) async {
    try {
      Uri url = Uri.https(AppApis.baseUrl, AppApis.login);
      var response = await http.post(
        url,
        body: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var responseBody = response.body;
        var json = jsonDecode(responseBody);
        return SuccessAPI<LoginResponseDto>(LoginResponseDto.fromJson(json));
      } else {
        return ErrorAPI<LoginResponseDto>(response.body);
      }
    } catch (e) {
      return ErrorAPI(e.toString());
    }
  }
}
