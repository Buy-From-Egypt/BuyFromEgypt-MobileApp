import 'dart:convert';
import 'package:buy_from_egypt/features/home/data/models/search_models.dart';
import 'package:dio/dio.dart';

class SearchService {
  static const String baseUrl = 'https://buy-from-egypt.vercel.app';
  static final Dio _dio = Dio();

  // You'll need to set this token dynamically after user login.
  // For now, it's a placeholder.
  static String? _authToken; 

  static void setAuthToken(String token) {
    _authToken = token;
  }

  static Future<Map<String, dynamic>> _getAuthHeaders() async {
    if (_authToken == null) {
      // In a real app, you might want to throw an error or redirect to login
      print('Warning: Auth token is not set. API calls might fail.');
      return {};
    }
    return {
      'Authorization': 'Bearer $_authToken',
    };
  }

  static Future<List<SearchUser>> searchUsers({
    required String keyword,
    String type = 'users',
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/search',
        queryParameters: {
          'keyword': keyword,
          'type': type,
        },
        options: Options(headers: await _getAuthHeaders()),
      );

      if (response.statusCode == 200) {
        // The API returns a list of user objects directly.
        final List<dynamic> usersList = response.data;
        return usersList.map((userJson) => SearchUser.fromJson(userJson)).toList();
      } else {
        throw Exception('Failed to search users: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  static Future<List<SearchHistoryItem>> getSearchHistory({String type = 'users'}) async {
    try {
      final response = await _dio.get(
        '$baseUrl/search/history',
        queryParameters: {'type': type},
        options: Options(headers: await _getAuthHeaders()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> historyList = response.data;
        return historyList.map((itemJson) => SearchHistoryItem.fromJson(itemJson)).toList();
      } else {
        throw Exception('Failed to get search history: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to get search history: $e');
    }
  }

  static Future<void> clearSearchHistory() async {
    try {
      final response = await _dio.delete(
        '$baseUrl/search/history',
        options: Options(headers: await _getAuthHeaders()),
      );

      if (response.statusCode == 200) {
        print('Search history cleared successfully');
      } else {
        throw Exception('Failed to clear search history: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to clear search history: $e');
    }
  }
} 