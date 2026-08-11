import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/profile/data/models/profile_response_dto.dart';

abstract class ProfileRepo {
  Future<ResultApi<ProfileResponseDto>> getProfile();
}
