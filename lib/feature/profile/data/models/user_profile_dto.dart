import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';

class UserProfileDto {
  final int id;
  final String email;
  final String name;
  final String avatar;
  final String role;
  final String phone;
  final String dateOfBirth;

  UserProfileDto({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.role,
    this.phone = '',
    this.dateOfBirth = '',
  });

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    return UserProfileDto(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      role: json['role'] ?? 'customer',
      phone: json['phone'] ?? json['phone_number'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? json['date_of_birth'] ?? json['dob'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'role': role,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      email: email,
      name: name,
      avatar: avatar,
      role: role,
      phone: phone,
      dateOfBirth: dateOfBirth,
    );
  }
}
