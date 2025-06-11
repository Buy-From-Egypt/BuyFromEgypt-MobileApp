import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:buy_from_egypt/core/utils/secure_storage.dart';
import 'package:buy_from_egypt/services/api_service.dart';

final logger = Logger();

class AuthUtils {
  static Future<void> saveUserSession(Map<String, dynamic> userData) async {
    try {
      // Save user data
      await SecureStorage.saveUserData(userData);
      
      // Save token if available
      if (userData['token'] != null) {
        await SecureStorage.saveToken(userData['token']);
      }

      // Save session expiry
      await SecureStorage.saveSessionInfo(
        DateTime.now().add(const Duration(days: 7)),
      );
    } catch (e) {
      logger.e('Error saving user session: $e', error: e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getUserSession() async {
    try {
      final userData = await SecureStorage.getUserData();
      if (userData == null) return null;

      // Check if token exists and is valid
      final token = await SecureStorage.getToken();
      if (token == null) return null;

      // Check if session is still valid
      final isSessionValid = await SecureStorage.isSessionValid();
      if (!isSessionValid) {
        await clearUserSession();
        return null;
      }

      return userData;
    } catch (e) {
      logger.e('Error getting user session: $e', error: e);
      return null;
    }
  }

  static Future<void> clearUserSession() async {
    try {
      await SecureStorage.clearUserSession();
      
      // Clear shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      logger.e('Error clearing user session: $e', error: e);
      rethrow;
    }
  }

  static Future<bool> isAuthenticated() async {
    try {
      final userData = await getUserSession();
      return userData != null;
    } catch (e) {
      logger.e('Error checking authentication status: $e', error: e);
      return false;
    }
  }

  static Future<bool> checkSession() async {
    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        logger.w('No internet connection while checking session');
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      if (!isLoggedIn) {
        logger.i('User is not logged in');
        return false;
      }

      // Check session expiry
      final isSessionValid = await SecureStorage.isSessionValid();
      if (!isSessionValid) {
        logger.i('Session has expired');
        await logout();
        return false;
      }

      logger.i('Session is valid');
      return true;
    } catch (e) {
      logger.e('Error checking session: $e', error: e);
      return false;
    }
  }

  static Future<void> logout() async {
    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        logger.w('No internet connection during logout');
      }

      // Call API logout endpoint
      try {
        await ApiService.logout();
      } catch (e) {
        logger.e('Error calling logout API: $e', error: e);
      }

      // Clear local storage
      await clearUserSession();

      logger.i('User logged out successfully');
    } catch (e) {
      logger.e('Error during logout: $e', error: e);
      throw Exception('Failed to logout: $e');
    }
  }

  static Future<void> refreshSession() async {
    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection. Please check your network and try again.');
      }

      // Update session expiry
      final expiryTime = DateTime.now().add(const Duration(days: 7));
      await SecureStorage.saveSessionInfo(expiryTime);

      logger.i('Session refreshed successfully');
    } catch (e) {
      logger.e('Failed to refresh session: $e', error: e);
      throw Exception('Failed to refresh session: $e');
    }
  }
}
