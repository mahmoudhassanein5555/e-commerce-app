import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/domain/entites/respons_entites/login_response_entity.dart';
import 'package:e_commerce_app/feature/auth/login/domain/repositories/data_source/login_data_source.dart';
import 'package:e_commerce_app/feature/auth/login/domain/repositories/repo/login_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepo)
class LoginRepoImp implements LoginRepo {
  final LoginDataSource _loginDataSource;
  LoginRepoImp(this._loginDataSource);
  @override
  Future<ResultApi<LoginResponseEntity>> login(String email, String password) =>
      _loginDataSource.login(email, password);
}
