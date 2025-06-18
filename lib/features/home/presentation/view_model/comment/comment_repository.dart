import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> getComments(String postId);
  Future<void> sendComment({required String content, required String postId});
}
