class UserProfileEntity {
  final int id;
  final String email;
  final String name;
  final String avatar;
  final String role;
  final String phone;
  final String dateOfBirth;

  const UserProfileEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.role,
    this.phone = '',
    this.dateOfBirth = '',
  });

  UserProfileEntity copyWith({
    int? id,
    String? email,
    String? name,
    String? avatar,
    String? role,
    String? phone,
    String? dateOfBirth,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
