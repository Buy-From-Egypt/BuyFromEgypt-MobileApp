import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static const String _tokenKey = 'auth_token';

  static Future<void> setToken(String token) async {
    print('Setting auth token in secure storage');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    print('Auth token saved successfully');
  }

  static Future<String?> getToken() async {
    print('Retrieving auth token from secure storage');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    print('Token ${token != null ? 'found' : 'not found'} in secure storage');
    return token;
  }

  static Future<void> removeToken() async {
    print('Removing auth token from secure storage');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    print('Auth token removed successfully');
  }
} 