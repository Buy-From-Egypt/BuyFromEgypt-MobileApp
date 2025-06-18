import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository.dart';
import 'package:buy_from_egypt/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CommentRepositoryImpl implements CommentRepository {
  final Logger _logger;

  CommentRepositoryImpl(this._logger);

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    try {
      final data = await ApiService.getComments(postId);
      final comments =
          data.map<CommentModel>((e) => CommentModel.fromJson(e)).toList();
      _logger.i('Comments fetched successfully: $comments');
      return comments;
    } catch (e, stackTrace) {
      _logger.e('Failed to fetch comments', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> sendComment({
    required String content,
    required String postId,
    String? parentCommentId,
  }) async {
    try {
      if (parentCommentId != null) {
        await ApiService.sendReply(
            parentCommentId: parentCommentId, content: content);
      } else {
        await ApiService.sendComment(postId: postId, content: content);
      }
      _logger.i('Comment sent successfully');
    } catch (e, stackTrace) {
      _logger.e('Failed to send comment', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
