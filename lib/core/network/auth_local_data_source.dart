import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveProfileImage(String path);
  Future<String?> getProfileImage();
  Future<void> saveUserData(String name, String email);
  Future<Map<String, String?>> getUserData();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImp implements AuthLocalDataSource {
  static const String _tokenKey = 'auth_token';
  static const String _profileImageKey = 'profile_image';

  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  @override
  Future<void> saveProfileImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);
  }

  @override
  Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey);
  }

  @override
  Future<void> saveUserData(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
    await prefs.setString(_userEmailKey, email);
  }

  @override
  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_userNameKey),
      'email': prefs.getString(_userEmailKey),
    };
  }
}
