import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/domain/entites/respons_entites/login_response_entity.dart';
import 'package:e_commerce_app/feature/auth/login/domain/repositories/repo/login_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginUseCase {
  final LoginRepo _loginRepo;
  LoginUseCase(this._loginRepo);
  Future<ResultApi<LoginResponseEntity>> invoke(
          {required String email, required String password}) async =>
      await _loginRepo.login(email, password);
}
