import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:e_commerce_app/feature/profile/data/models/user_profile_dto.dart';
import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:e_commerce_app/feature/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<ResultApi<UserProfileEntity>> getProfile() async {
    final response = await _remoteDataSource.getProfile();
    switch (response) {
      case SuccessAPI<UserProfileDto>():
        return SuccessAPI<UserProfileEntity>(response.data?.toEntity());
      case ErrorAPI<UserProfileDto>():
        return ErrorAPI<UserProfileEntity>(response.messageError);
    }
  }

  @override
  Future<ResultApi<UserProfileEntity>> updateProfile({
    required int id,
    required String name,
    required String email,
    String? avatar,
    String? phone,
    String? dateOfBirth,
  }) async {
    final response = await _remoteDataSource.updateProfile(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      phone: phone,
      dateOfBirth: dateOfBirth,
    );
    switch (response) {
      case SuccessAPI<UserProfileDto>():
        return SuccessAPI<UserProfileEntity>(response.data?.toEntity());
      case ErrorAPI<UserProfileDto>():
        return ErrorAPI<UserProfileEntity>(response.messageError);
    }
  }
}
