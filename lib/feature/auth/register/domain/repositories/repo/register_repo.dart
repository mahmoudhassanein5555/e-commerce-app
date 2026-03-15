import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/reques_entites/register_request_entites.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/respons_entites/register_response_entity.dart';

abstract class RegisterRepo {
  Future<ResultApi<RegisterResponseEntity>> register(
      RegisterRequestEntites request);
}
