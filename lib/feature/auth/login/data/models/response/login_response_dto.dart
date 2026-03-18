import 'package:e_commerce_app/feature/auth/login/domain/entites/respons_entites/login_response_entity.dart';

class LoginResponseDto {
  final String accessToken;
  final String refreshToken;

  LoginResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
  //to entity
  LoginResponseEntity toEntity() => LoginResponseEntity(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}
