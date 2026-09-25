import 'dart:convert';
import 'package:e_commerce_app/core/constants/app_apis.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view_model/home_cubit/secure_storage_service.dart';
import 'package:e_commerce_app/feature/profile/data/models/user_profile_dto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class ProfileRemoteDataSource {
  Future<ResultApi<UserProfileDto>> getProfile();
  Future<ResultApi<UserProfileDto>> updateProfile({
    required int id,
    required String name,
    required String email,
    String? avatar,
    String? phone,
    String? dateOfBirth,
  });
}

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SecureStorageService _storageService;

  ProfileRemoteDataSourceImpl(this._storageService);

  @override
  Future<ResultApi<UserProfileDto>> getProfile() async {
    try {
      final token = await _storageService.getToken();
      final url = Uri.https(AppApis.baseUrl, AppApis.profile);

      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final dto = UserProfileDto.fromJson(json);
        final savedData = await _storageService.getUserData();
        final avatarToUse = (dto.avatar.isNotEmpty) ? dto.avatar : (savedData['avatar'] ?? '');
        final nameToUse = (dto.name.isNotEmpty) ? dto.name : (savedData['name'] ?? '');
        final phoneToUse = (dto.phone.isNotEmpty) ? dto.phone : (savedData['phone'] ?? '');
        final dobToUse = (dto.dateOfBirth.isNotEmpty) ? dto.dateOfBirth : (savedData['dateOfBirth'] ?? '');

        await _storageService.saveUserData(
          id: dto.id,
          name: nameToUse,
          email: dto.email,
          avatar: avatarToUse,
          phone: phoneToUse,
          dateOfBirth: dobToUse,
        );
        return SuccessAPI<UserProfileDto>(
          UserProfileDto(
            id: dto.id,
            name: nameToUse,
            email: dto.email,
            avatar: avatarToUse,
            role: dto.role,
            phone: phoneToUse,
            dateOfBirth: dobToUse,
          ),
        );
      } else {
        final savedData = await _storageService.getUserData();
        if (savedData['name'] != null && (savedData['name'] as String).isNotEmpty) {
          return SuccessAPI<UserProfileDto>(
            UserProfileDto(
              id: savedData['id'] ?? 1,
              name: savedData['name']!,
              email: savedData['email'] ?? '',
              avatar: savedData['avatar'] ?? '',
              phone: savedData['phone'] ?? '',
              dateOfBirth: savedData['dateOfBirth'] ?? '',
              role: 'customer',
            ),
          );
        }
        return ErrorAPI<UserProfileDto>('Failed to load profile: ${response.body}');
      }
    } catch (e) {
      final savedData = await _storageService.getUserData();
      if (savedData['name'] != null && (savedData['name'] as String).isNotEmpty) {
        return SuccessAPI<UserProfileDto>(
          UserProfileDto(
            id: savedData['id'] ?? 1,
            name: savedData['name']!,
            email: savedData['email'] ?? '',
            avatar: savedData['avatar'] ?? '',
            phone: savedData['phone'] ?? '',
            dateOfBirth: savedData['dateOfBirth'] ?? '',
            role: 'customer',
          ),
        );
      }
      return ErrorAPI<UserProfileDto>(e.toString());
    }
  }

  @override
  Future<ResultApi<UserProfileDto>> updateProfile({
    required int id,
    required String name,
    required String email,
    String? avatar,
    String? phone,
    String? dateOfBirth,
  }) async {
    try {
      final token = await _storageService.getToken();
      final url = Uri.https(AppApis.baseUrl, '${AppApis.users}$id');

      await _storageService.saveUserData(
        id: id,
        name: name,
        email: email,
        avatar: avatar,
        phone: phone,
        dateOfBirth: dateOfBirth,
      );

      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final bodyData = <String, dynamic>{
        'name': name,
        'email': email,
      };
      if (avatar != null && avatar.isNotEmpty) {
        bodyData['avatar'] = avatar;
      }
      if (phone != null && phone.isNotEmpty) {
        bodyData['phone'] = phone;
      }
      if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
        bodyData['dateOfBirth'] = dateOfBirth;
      }

      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(bodyData),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final dto = UserProfileDto.fromJson(json);
        final finalAvatar = (dto.avatar.isNotEmpty) ? dto.avatar : (avatar ?? '');
        final finalPhone = (dto.phone.isNotEmpty) ? dto.phone : (phone ?? '');
        final finalDob = (dto.dateOfBirth.isNotEmpty) ? dto.dateOfBirth : (dateOfBirth ?? '');

        await _storageService.saveUserData(
          id: dto.id,
          name: dto.name,
          email: dto.email,
          avatar: finalAvatar,
          phone: finalPhone,
          dateOfBirth: finalDob,
        );
        return SuccessAPI<UserProfileDto>(
          UserProfileDto(
            id: dto.id,
            name: dto.name,
            email: dto.email,
            avatar: finalAvatar,
            role: dto.role,
            phone: finalPhone,
            dateOfBirth: finalDob,
          ),
        );
      } else {
        return SuccessAPI<UserProfileDto>(
          UserProfileDto(
            id: id,
            name: name,
            email: email,
            avatar: avatar ?? '',
            role: 'customer',
            phone: phone ?? '',
            dateOfBirth: dateOfBirth ?? '',
          ),
        );
      }
    } catch (e) {
      await _storageService.saveUserData(
        id: id,
        name: name,
        email: email,
        avatar: avatar,
        phone: phone,
        dateOfBirth: dateOfBirth,
      );
      return SuccessAPI<UserProfileDto>(
        UserProfileDto(
          id: id,
          name: name,
          email: email,
          avatar: avatar ?? '',
          role: 'customer',
          phone: phone ?? '',
          dateOfBirth: dateOfBirth ?? '',
        ),
      );
    }
  }
}
