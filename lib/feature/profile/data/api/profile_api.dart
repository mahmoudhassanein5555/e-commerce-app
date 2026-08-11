import 'package:injectable/injectable.dart';

@injectable
class ProfileApi {
  // Mocking API call for now as per "existing architecture"
  Future<Map<String, dynamic>> getProfile() async {
    // In a real app, this would call http.get
    return {
      'name': 'User Name',
      'email': 'user@example.com',
    };
  }
}
