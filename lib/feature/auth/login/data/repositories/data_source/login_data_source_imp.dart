import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/data/api/login_api.dart';
import 'package:e_commerce_app/feature/auth/login/data/models/response/login_response_dto.dart';
import 'package:e_commerce_app/feature/auth/login/domain/entites/respons_entites/login_response_entity.dart';
import 'package:e_commerce_app/feature/auth/login/domain/repositories/data_source/login_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginDataSource)
class LoginDataSourceImp implements LoginDataSource {
  final LoginApi _loginApi;
  LoginDataSourceImp(this._loginApi);
  @override
  Future<ResultApi<LoginResponseEntity>> login(
      String email, String password) async {
    var response = await _loginApi.login(email, password);
    switch (response) {
      case SuccessAPI<LoginResponseDto>():
        return SuccessAPI<LoginResponseEntity>(response.data?.toEntity());
      case ErrorAPI<LoginResponseDto>():
        return ErrorAPI<LoginResponseEntity>(response.messageError);
    }
  }
}
