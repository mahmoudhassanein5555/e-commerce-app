import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/domain/entites/respons_entites/login_response_entity.dart';

abstract class LoginDataSource {
  Future<ResultApi<LoginResponseEntity>> login(String email, String password);
}
