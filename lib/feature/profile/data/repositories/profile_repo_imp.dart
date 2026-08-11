import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/profile/data/api/profile_api.dart';
import 'package:e_commerce_app/feature/profile/data/models/profile_response_dto.dart';
import 'package:e_commerce_app/feature/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImp implements ProfileRepo {
  final ProfileApi _api;

  ProfileRepoImp(this._api);

  @override
  Future<ResultApi<ProfileResponseDto>> getProfile() async {
    try {
      final data = await _api.getProfile();
      return SuccessAPI(ProfileResponseDto.fromJson(data));
    } catch (e) {
      return ErrorAPI(e.toString());
    }
  }
}
