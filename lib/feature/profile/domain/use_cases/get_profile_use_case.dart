import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:e_commerce_app/feature/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<ResultApi<UserProfileEntity>> invoke() async {
    return await _repository.getProfile();
  }
}
