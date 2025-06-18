import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/send_comment_usecase.dart';

class SendCommentUseCaseImpl implements SendCommentUseCase {
  final CommentRepository _repository;

  SendCommentUseCaseImpl(this._repository);

  @override
  Future<void> call({
    required String content,
    required String postId,
  }) async {
    await _repository.sendComment(
      content: content,
      postId: postId,
    );
  }
}
