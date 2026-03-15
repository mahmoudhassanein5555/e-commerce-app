import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/reques_entites/register_request_entites.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/respons_entites/register_response_entity.dart';
import 'package:e_commerce_app/feature/auth/register/domain/repositories/repo/register_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final RegisterRepo repo;
  RegisterUseCase(this.repo);
  Future<ResultApi<RegisterResponseEntity>> invoke(
          RegisterRequestEntites request) =>
      repo.register(request);
}
