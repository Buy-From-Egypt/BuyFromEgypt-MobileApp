import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:buy_from_egypt/core/utils/secure_storage.dart';

final logger = Logger();

class MarketplaceApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://buy-from-egypt.vercel.app',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  static Future<Response> request({
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('User not authenticated');
      }

      final options = Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      switch (method.toUpperCase()) {
        case 'GET':
          return await _dio.get(endpoint, options: options);
        case 'POST':
          return await _dio.post(endpoint, data: body, options: options);
        case 'PUT':
          return await _dio.put(endpoint, data: body, options: options);
        case 'DELETE':
          return await _dio.delete(endpoint, data: body, options: options);
        default:
          throw Exception('Unsupported HTTP method: $method');
      }
    } catch (e) {
      logger.e('[Marketplace API] Error: $e');
      rethrow;
    }
  }

  static dynamic handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.data}');
    }
  }
}
