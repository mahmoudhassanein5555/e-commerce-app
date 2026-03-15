import 'package:e_commerce_app/feature/auth/register/domain/entites/respons_entites/register_response_entity.dart';

class RegisterResponseDto {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;
  String? createdAt;
  String? updatedAt;

  RegisterResponseDto({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  RegisterResponseEntity toEntity() => RegisterResponseEntity(
        name: name = "",
        password: password = "",
        avatar: avatar = "",
        email: email = "",
        id: id = 0,
        role: role = "",
        createdAt: createdAt = "",
        updatedAt: updatedAt = "",
      );
}
