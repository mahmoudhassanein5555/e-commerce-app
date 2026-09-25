import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:e_commerce_app/feature/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<ResultApi<UserProfileEntity>> invoke({
    required int id,
    required String name,
    required String email,
    String? avatar,
    String? phone,
    String? dateOfBirth,
  }) async {
    return await _repository.updateProfile(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      phone: phone,
      dateOfBirth: dateOfBirth,
    );
  }
}
