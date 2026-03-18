import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/register/data/api/register_api.dart';
import 'package:e_commerce_app/feature/auth/register/data/models/request/register_request_dto.dart';
import 'package:e_commerce_app/feature/auth/register/data/models/response/register_response_dto.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/reques_entites/register_request_entites.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/respons_entites/register_response_entity.dart';
import 'package:e_commerce_app/feature/auth/register/domain/repositories/data_source/register_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterDataSource)
class RegisterDataSourceImp implements RegisterDataSource {
  RegisterDataSourceImp(this._api);
  final RegisterApi _api;
  @override
  Future<ResultApi<RegisterResponseEntity>> register(
      RegisterRequestEntites request) async {
    final result = await _api.register(RegisterRequestDto(
        name: request.name, email: request.email, password: request.password));
    switch (result) {
      case SuccessAPI<RegisterResponseDto>():
        return SuccessAPI<RegisterResponseEntity>(result.data?.toEntity());
      case ErrorAPI<RegisterResponseDto>():
        return ErrorAPI<RegisterResponseEntity>(result.messageError);
    }
  }
}
