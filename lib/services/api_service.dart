import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final logger = Logger();

class ApiService {
  static const String baseUrl = 'https://buy-from-egypt.vercel.app';

  static Uri _buildUrl(String endpoint) => Uri.parse('$baseUrl$endpoint');

  static Future<http.Response> _request({
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUrl(endpoint);
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    try {
      logger.i('[API][$method] $uri');
      if (body != null) logger.i('[API][$method] Payload: ${jsonEncode(body)}');

      late http.Response response;

      switch (method) {
        case 'POST':
          response = await http.post(uri, headers: defaultHeaders, body: jsonEncode(body));
          break;
        case 'PUT':
          response = await http.put(uri, headers: defaultHeaders, body: jsonEncode(body));
          break;
        case 'GET':
          response = await http.get(uri, headers: defaultHeaders);
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: defaultHeaders);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      logger.i('[API][$method] Status: ${response.statusCode}');
      logger.i('[API][$method] Body: ${response.body}');
      return response;
    } on SocketException {
      throw Exception('No internet connection.');
    } catch (e) {
      logger.e('[API][$method] Error: $e');
      rethrow;
    }
  }

  static dynamic _handleResponse(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return body;
      } else {
        final message = body['message'] ?? 'Server error';
        throw Exception('Error ${response.statusCode}: $message');
      }
    } on FormatException {
      throw Exception('Invalid response format from server');
    } catch (e) {
      logger.e('[API] Error handling response: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    final requiredFields = [
      'name', 'email', 'password', 'phoneNumber', 'type',
      'taxId', 'nationalId', 'country', 'age'
    ];

    for (final field in requiredFields) {
      if (userData[field]?.toString().trim().isEmpty ?? true) {
        throw Exception('Missing required field: $field');
      }
    }

    final cleanedData = {
      'name': userData['name'].toString().trim(),
      'email': userData['email'].toString().trim().toLowerCase(),
      'password': userData['password'].toString(),
      'phoneNumber': userData['phoneNumber'].toString().trim(),
      'type': userData['type'].toString().trim().toUpperCase(),
      'taxId': userData['taxId'].toString().trim(),
      'registrationNumber': userData['registrationNumber']?.toString().trim() ?? '',
      'industrySector': userData['industrySector']?.toString().trim() ?? '',
      'commercial': userData['commercial']?.toString().trim() ?? '',
      'nationalId': userData['nationalId'].toString().trim(),
      'country': userData['country'].toString().trim(),
      'age': int.parse(userData['age'].toString()),
      'address': userData['address']?.toString().trim() ?? '',
    };

    final res = await _request(
      endpoint: '/auth/register',
      method: 'POST',
      body: cleanedData,
    );

    return _handleResponse(res);
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _request(
      endpoint: '/auth/login',
      method: 'POST',
      body: {'email': email, 'password': password},
    );
    final data = _handleResponse(res);

    if (data['status'] == 'INACTIVE') {
      throw Exception('INACTIVE_ACCOUNT');
    }
    return data;
  }

  static Future<void> logout() async {
    final res = await _request(endpoint: '/auth/logout', method: 'POST');
    _handleResponse(res);
  }

  static Future<void> verifyOtp(String identifier, String otpCode) async {
    final res = await _request(
      endpoint: '/auth/verify-otp',
      method: 'POST',
      body: {'identifier': identifier, 'otpCode': otpCode},
    );
    _handleResponse(res);
  }

  static Future<Map<String, dynamic>> verifyOtpReset(String identifier, String otpCode) async {
    final res = await _request(
      endpoint: '/auth/verify-otp-link',
      method: 'POST',
      body: {'identifier': identifier, 'otpCode': otpCode},
    );
    return _handleResponse(res);
  }

  static Future<void> requestOtp(String identifier) async {
    final res = await _request(
      endpoint: '/auth/request-reset',
      method: 'POST',
      body: {'identifier': identifier},
    );
    _handleResponse(res);
  }

  static Future<void> resetPassword(String email, String newPass, String confirmPass) async {
    final res = await _request(
      endpoint: '/auth/reset-password',
      method: 'POST',
      body: {
        'email': email,
        'newPassword': newPass,
        'confirmPassword': confirmPass,
      },
    );
    _handleResponse(res);
  }

  static Future<void> approveUser(String userId, String token) async {
  final res = await _request(
    endpoint: '/users/admin/approveUser/$userId',
    method: 'PUT',
    headers: {'Authorization': 'Bearer $token'},
  );
  _handleResponse(res);
}

static Future<void> deactivateUser(String userId, String token) async {
  final res = await _request(
    endpoint: '/users/admin/deactivateUser/$userId',
    method: 'PUT',
    headers: {'Authorization': 'Bearer $token'},
  );
  _handleResponse(res);
}


  static Future<List<dynamic>> getAllUsers(String token) async {
    final res = await _request(
      endpoint: '/users/admin',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );
    return _handleResponse(res);
  }

  static Future<void> deleteUser(String userId, String token) async {
    final res = await _request(
      endpoint: '/users/admin/$userId',
      method: 'DELETE',
      headers: {'Authorization': 'Bearer $token'},
    );
    _handleResponse(res);
  }

  static Future<void> updateUser(String userId, Map<String, dynamic> userData, String token) async {
    final res = await _request(
      endpoint: '/users/admin/$userId',
      method: 'PUT',
      headers: {'Authorization': 'Bearer $token'},
      body: userData,
    );
    _handleResponse(res);
  }
}
