// send_comment_use_case.dart
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository.dart';

abstract class SendCommentUseCase {
  Future<void> call({required String content, required String postId});
}

class SendCommentUseCaseImpl implements SendCommentUseCase {
  final CommentRepository repository;

  SendCommentUseCaseImpl(this.repository);

  @override
  Future<void> call({required String content, required String postId}) async {
    try {
      await repository.sendComment(content: content, postId: postId);
    } catch (e) {
      rethrow;
    }
  }
}
