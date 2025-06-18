import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final logger = Logger();

class ApiService {
  static const String _baseUrl = 'https://buy-from-egypt.vercel.app';

  static Uri _buildUrl(String endpoint) => Uri.parse('$_baseUrl$endpoint');

  // ===================== TOKEN =====================
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // ===================== REQUEST =====================
  static Future<http.Response> request({
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool useAuth = false,
  }) async {
    final uri = _buildUrl(endpoint);
    final token = useAuth ? await getToken() : null;

    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      ...?headers,
    };

    try {
      logger.i('[API][$method] $uri');
      if (body != null) logger.i('Payload: ${jsonEncode(body)}');

      late http.Response response;
      switch (method) {
        case 'POST':
          response = await http.post(uri,
              headers: defaultHeaders, body: jsonEncode(body));
          break;
        case 'PUT':
          response = await http.put(uri,
              headers: defaultHeaders, body: jsonEncode(body));
          break;
        case 'GET':
          response = await http.get(uri, headers: defaultHeaders);
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: defaultHeaders);
          break;
        default:
          throw Exception('Unsupported method: $method');
      }

      logger.i('Status: ${response.statusCode}');
      logger.i('Response: ${response.body}');
      return response;
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      logger.e('Error: $e');
      rethrow;
    }
  }

  static dynamic handleResponse(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return body;
      } else {
        final message = body['message'] ?? 'Error occurred';
        throw Exception('Error ${response.statusCode}: $message');
      }
    } catch (e) {
      logger.e('Response handling error: $e');
      rethrow;
    }
  }

  // ===================== AUTH =====================
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final res = await request(
      endpoint: '/auth/login',
      method: 'POST',
      body: {'email': email, 'password': password},
    );
    final data = handleResponse(res);
    if (data['status'] == 'INACTIVE') throw Exception('INACTIVE_ACCOUNT');
    await saveToken(data['token']);
    return data;
  }

  static Future<void> logout() async {
    await clearToken();
    final res =
        await request(endpoint: '/auth/logout', method: 'POST', useAuth: true);
    handleResponse(res);
  }

  static Future<Map<String, dynamic>> register(
      Map<String, dynamic> userData) async {
    final required = [
      'name',
      'email',
      'password',
      'phoneNumber',
      'type',
      'taxId',
      'nationalId',
      'country',
      'age'
    ];

    for (final key in required) {
      if (userData[key]?.toString().trim().isEmpty ?? true) {
        throw Exception('Missing field: $key');
      }
    }

    final body = {
      ...userData,
      'email': userData['email'].toString().trim().toLowerCase(),
      'type': userData['type'].toString().toUpperCase(),
      'age': int.parse(userData['age'].toString()),
    };

    final res =
        await request(endpoint: '/auth/register', method: 'POST', body: body);
    return handleResponse(res);
  }

  static Future<void> verifyOtp(String identifier, String otpCode) async {
    final res = await request(
      endpoint: '/auth/verify-otp',
      method: 'POST',
      body: {'identifier': identifier, 'otpCode': otpCode},
    );
    handleResponse(res);
  }

  static Future<Map<String, dynamic>> verifyOtpReset(
      String identifier, String otpCode) async {
    final res = await request(
      endpoint: '/auth/verify-otp-link',
      method: 'POST',
      body: {'identifier': identifier, 'otpCode': otpCode},
    );
    return handleResponse(res);
  }

  static Future<void> requestOtp(String identifier) async {
    final res = await request(
      endpoint: '/auth/request-reset',
      method: 'POST',
      body: {'identifier': identifier},
    );
    handleResponse(res);
  }

  static Future<void> resetPassword(
      String email, String newPass, String confirmPass) async {
    final res = await request(
      endpoint: '/auth/reset-password',
      method: 'POST',
      body: {
        'email': email,
        'newPassword': newPass,
        'confirmPassword': confirmPass,
      },
    );
    handleResponse(res);
  }

  // ===================== ADMIN =====================
  static Future<List<dynamic>> getAllUsers() async {
    final res =
        await request(endpoint: '/users/admin', method: 'GET', useAuth: true);
    return handleResponse(res);
  }

  static Future<void> approveUser(String userId) async {
    final res = await request(
        endpoint: '/users/admin/approveUser/$userId',
        method: 'PUT',
        useAuth: true);
    handleResponse(res);
  }

  static Future<void> deactivateUser(String userId) async {
    final res = await request(
        endpoint: '/users/admin/deactivateUser/$userId',
        method: 'PUT',
        useAuth: true);
    handleResponse(res);
  }

  static Future<void> deleteUser(String userId) async {
    final res = await request(
        endpoint: '/users/admin/$userId', method: 'DELETE', useAuth: true);
    handleResponse(res);
  }

  static Future<void> updateUser(
      String userId, Map<String, dynamic> data) async {
    final res = await request(
      endpoint: '/users/admin/$userId',
      method: 'PUT',
      body: data,
      useAuth: true,
    );
    handleResponse(res);
  }

  // ===================== COMMENTS =====================
  static Future<List<dynamic>> getComments(String postId) async {
    final res = await request(
      endpoint: '/comments/allComments/$postId',
      method: 'GET',
      useAuth: true,
    );
    return handleResponse(res);
  }

  static Future<Map<String, dynamic>> sendComment({
    required String postId,
    required String content,
    int? rating,
  }) async {
    final body = {
      'postId': postId,
      'content': content,
      if (rating != null) 'rating': rating,
    };

    final res = await request(
        endpoint: '/comments', method: 'POST', body: body, useAuth: true);
    return handleResponse(res);
  }

  static Future<Map<String, dynamic>> sendReply({
    required String parentCommentId,
    required String content,
  }) async {
    final res = await request(
      endpoint: '/comments/reply',
      method: 'POST',
      body: {'parentCommentId': parentCommentId, 'content': content},
      useAuth: true,
    );
    return handleResponse(res);
  }

  static Future<void> likeComment(String commentId) async {
    final res = await request(
      endpoint: '/comments/like',
      method: 'POST',
      body: {'commentId': commentId},
      useAuth: true,
    );
    handleResponse(res);
  }

  static Future<void> dislikeComment(String commentId) async {
    final res = await request(
      endpoint: '/comments/dislike',
      method: 'POST',
      body: {'commentId': commentId},
      useAuth: true,
    );
    handleResponse(res);
  }

  static Future<void> rateComment({
    required String commentId,
    required int rating,
  }) async {
    final res = await request(
      endpoint: '/comments/rate',
      method: 'POST',
      body: {'commentId': commentId, 'rating': rating},
      useAuth: true,
    );
    handleResponse(res);
  }

  static Future<void> deleteComment(String commentId) async {
    final res = await request(
        endpoint: '/comments/$commentId', method: 'DELETE', useAuth: true);
    handleResponse(res);
  }
}
