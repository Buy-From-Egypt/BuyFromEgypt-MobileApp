import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

final logger = Logger();

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _sessionExpiryKey = 'session_expiry';

  // Token methods
  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (e) {
      logger.e('Error saving token: $e', error: e);
      rethrow;
    }
  }

  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      logger.e('Error getting token: $e', error: e);
      return null;
    }
  }

  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
    } catch (e) {
      logger.e('Error deleting token: $e', error: e);
      rethrow;
    }
  }

  // User data methods
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final jsonString = jsonEncode(userData);
      await _storage.write(key: _userDataKey, value: jsonString);
    } catch (e) {
      logger.e('Error saving user data: $e', error: e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final jsonString = await _storage.read(key: _userDataKey);
      if (jsonString == null) return null;
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      logger.e('Error getting user data: $e', error: e);
      return null;
    }
  }

  static Future<void> deleteUserData() async {
    try {
      await _storage.delete(key: _userDataKey);
    } catch (e) {
      logger.e('Error deleting user data: $e', error: e);
      rethrow;
    }
  }

  // User credentials methods
  static Future<void> saveUserCredentials(String email, String password) async {
    try {
      await _storage.write(key: 'user_email', value: email);
      await _storage.write(key: 'user_password', value: password);
    } catch (e) {
      logger.e('Error saving user credentials: $e', error: e);
      rethrow;
    }
  }

  static Future<Map<String, String?>> getUserCredentials() async {
    try {
      final email = await _storage.read(key: 'user_email');
      final password = await _storage.read(key: 'user_password');
      return {
        'email': email,
        'password': password,
      };
    } catch (e) {
      logger.e('Error getting user credentials: $e', error: e);
      return {'email': null, 'password': null};
    }
  }

  static Future<void> deleteUserCredentials() async {
    try {
      await _storage.delete(key: 'user_email');
      await _storage.delete(key: 'user_password');
    } catch (e) {
      logger.e('Error deleting user credentials: $e', error: e);
      rethrow;
    }
  }

  // Session management methods
  static Future<void> saveSessionInfo(DateTime expiryTime) async {
    try {
      await _storage.write(
        key: _sessionExpiryKey,
        value: expiryTime.toIso8601String(),
      );
    } catch (e) {
      logger.e('Error saving session info: $e', error: e);
      rethrow;
    }
  }

  static Future<bool> isSessionValid() async {
    try {
      final expiryString = await _storage.read(key: _sessionExpiryKey);
      if (expiryString == null) return false;

      final expiryTime = DateTime.parse(expiryString);
      return DateTime.now().isBefore(expiryTime);
    } catch (e) {
      logger.e('Error checking session validity: $e', error: e);
      return false;
    }
  }

  static Future<void> clearUserSession() async {
    try {
      await Future.wait([
        deleteToken(),
        deleteUserData(),
        deleteUserCredentials(),
        _storage.delete(key: _sessionExpiryKey),
      ]);
    } catch (e) {
      logger.e('Error clearing user session: $e', error: e);
      rethrow;
    }
  }
} 