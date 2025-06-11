import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buy_from_egypt/core/utils/secure_storage.dart';

class ApiService {
  static const String baseUrl = 'YOUR_BASE_URL'; // Replace with your actual base URL

  // Headers
  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
      };

  static Map<String, String> get _authHeaders => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${SecureStorage.getToken()}',
      };

  // Register
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String type,
    required String taxId,
    required String registrationNumber,
    required String industrySector,
    required String commercial,
    required String nationalId,
    required String country,
    required String address,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: _headers,
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'type': type,
        'taxId': taxId,
        'registrationNumber': registrationNumber,
        'industrySector': industrySector,
        'commercial': commercial,
        'nationalId': nationalId,
        'country': country,
        'address': address,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  // Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: _headers,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await SecureStorage.saveToken(data['token']);
      return data;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Logout
  static Future<void> logout() async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout'),
      headers: _authHeaders,
    );

    if (response.statusCode == 200) {
      await SecureStorage.deleteToken();
    } else {
      throw Exception('Failed to logout: ${response.body}');
    }
  }

  // Request OTP
  static Future<void> requestOtp(String identifier) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/request-reset'),
      headers: _headers,
      body: jsonEncode({
        'identifier': identifier,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to request OTP: ${response.body}');
    }
  }

  // Verify OTP
  static Future<Map<String, dynamic>> verifyOtp({
    required String identifier,
    required String otpCode,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/verify-otp'),
      headers: _headers,
      body: jsonEncode({
        'identifier': identifier,
        'otpCode': otpCode,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify OTP: ${response.body}');
    }
  }

  // Reset Password
  static Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: _headers,
      body: jsonEncode({
        'token': token,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password: ${response.body}');
    }
  }
} 