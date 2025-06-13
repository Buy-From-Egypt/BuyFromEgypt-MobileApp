import 'package:buy_from_egypt/core/config/app_config.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository.dart';
import 'package:dio/dio.dart';

class CommentRepositoryImpl implements CommentRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    try {
      final response = await _dio.get('/comments', queryParameters: {
        'postId': postId,
      });

      if (response.data is List) {
        final List data = response.data;
        return data.map((item) => CommentModel.fromJson(item)).toList();
      } else {
        throw Exception('Invalid response format: Expected a list of comments');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Network error: Please check your internet connection.');
      } else if (e.response != null) {
        switch (e.response!.statusCode) {
          case 404:
            throw Exception('Comments endpoint not found (404).');
          case 500:
            throw Exception('Server error (500): Please try again later.');
          default:
            throw Exception(
                'Failed to fetch comments: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        }
      } else {
        throw Exception('Failed to fetch comments: ${e.message}');
      }
    } catch (e) {
      throw Exception(
          'An unexpected error occurred while fetching comments: $e');
    }
  }

  @override
  Future<void> sendComment({
    required String contant,
    required String postId,
  }) async {
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjZjZlZGY5NC05ZWYyLTQ1MzQtYjU1NS1jNWYyN2ZjN2ZlYmEiLCJlbWFpbCI6ImFiZGVscmFobWFuLmFkZWwwNjNAZ21haWwuY29tIiwiYWN0aXZlIjp0cnVlLCJyb2xlIjoiQURNSU4iLCJ0eXBlIjoiRVhQT1JURVIiLCJpYXQiOjE3NDk3NDE1NTAsImV4cCI6MTc0OTc0NTE1MH0.xwCibMj4mwOtQLEPP63TN1zLa3BKPF-qGh-gg0dWA4k"; // حطي التوكن الصح هنا

    try {
      await _dio.post(
        '/comments',
        data: {
          'contant': contant,
          'postId': postId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Network error: Please check your internet connection.');
      } else if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw Exception(
                'Bad request: ${e.response?.data['message'] ?? 'Invalid comment data.'}');
          case 401:
            throw Exception('Unauthorized: Invalid or expired token.');
          case 500:
            throw Exception('Server error (500): Failed to send comment.');
          default:
            throw Exception(
                'Failed to send comment: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        }
      } else {
        throw Exception('Failed to send comment: ${e.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred while sending comment: $e');
    }
  }
}
