import 'package:e_commerce_app/feature/auth/register/domain/entites/reques_entites/register_request_entites.dart';

class RegisterRequestDto {
  String? name;
  String? email;
  String? password;
  String? avatar;

  RegisterRequestDto({
    this.name,
    this.email,
    this.password,
    this.avatar,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['avatar'] = "https://picsum.photos/800";
    return data;
  }

  RegisterRequestEntites toEntity() => RegisterRequestEntites(
      name: name = "", email: email = "", password: password = "");
}
