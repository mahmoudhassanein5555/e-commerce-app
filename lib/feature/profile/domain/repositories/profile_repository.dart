import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<ResultApi<UserProfileEntity>> getProfile();
  Future<ResultApi<UserProfileEntity>> updateProfile({
    required int id,
    required String name,
    required String email,
    String? avatar,
    String? phone,
    String? dateOfBirth,
  });
}
