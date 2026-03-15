import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/reques_entites/register_request_entites.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/respons_entites/register_response_entity.dart';
import 'package:e_commerce_app/feature/auth/register/domain/repositories/data_source/register_data_source.dart';
import 'package:e_commerce_app/feature/auth/register/domain/repositories/repo/register_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepo)
class RegisterRepoImp implements RegisterRepo {
  final RegisterDataSource _dataSource;
  RegisterRepoImp(this._dataSource);
  @override
  Future<ResultApi<RegisterResponseEntity>> register(
          RegisterRequestEntites request) async =>
      await _dataSource.register(request);
}
