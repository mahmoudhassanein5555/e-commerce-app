class RegisterResponseEntity {
  int id;
  String email;
  String password;
  String name;
  String role;
  String avatar;
  String createdAt;
  String updatedAt;

  RegisterResponseEntity({
    this.id = 0,
    this.email = "",
    this.password = "",
    this.name = "",
    this.role = "",
    this.avatar = "",
    this.createdAt = "",
    this.updatedAt = "",
  });
}

