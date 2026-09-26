import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  static const String _keyToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserAvatar = 'user_avatar';
  static const String _keyUserPhone = 'user_phone';
  static const String _keyUserDob = 'user_dob';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> saveToken(String token, {String? refreshToken}) async {
    final prefs = await _prefs;
    await prefs.setString(_keyToken, token);
    if (refreshToken != null) {
      await prefs.setString(_keyRefreshToken, refreshToken);
    }
  }

  Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyToken);
  }

  Future<void> saveUserData({
    required int id,
    required String name,
    required String email,
    String? avatar,
    String? phone,
    String? dateOfBirth,
  }) async {
    final prefs = await _prefs;
    await prefs.setInt(_keyUserId, id);
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserEmail, email);
    if (avatar != null) {
      await prefs.setString(_keyUserAvatar, avatar);
    }
    if (phone != null) {
      await prefs.setString(_keyUserPhone, phone);
    }
    if (dateOfBirth != null) {
      await prefs.setString(_keyUserDob, dateOfBirth);
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await _prefs;
    return {
      'id': prefs.getInt(_keyUserId),
      'name': prefs.getString(_keyUserName),
      'email': prefs.getString(_keyUserEmail),
      'avatar': prefs.getString(_keyUserAvatar),
      'phone': prefs.getString(_keyUserPhone),
      'dateOfBirth': prefs.getString(_keyUserDob),
    };
  }

  Future<void> clearSession() async {
    final prefs = await _prefs;
    await prefs.remove(_keyToken);
    await prefs.remove(_keyRefreshToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserAvatar);
    await prefs.remove(_keyUserPhone);
    await prefs.remove(_keyUserDob);
  }
}
