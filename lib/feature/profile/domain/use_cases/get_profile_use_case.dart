import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/profile/data/models/profile_response_dto.dart';
import 'package:e_commerce_app/feature/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepo _repository;

  GetProfileUseCase(this._repository);

  Future<ResultApi<ProfileResponseDto>> invoke() {
    return _repository.getProfile();
  }
}
