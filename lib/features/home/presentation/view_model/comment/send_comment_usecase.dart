import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository.dart';

abstract class SendCommentUseCase {
  Future<void> call({required String contant, required String postId});
}

class SendCommentUseCaseImpl implements SendCommentUseCase {
  final CommentRepository repository;

  SendCommentUseCaseImpl(this.repository);

  @override
  Future<void> call({required String contant, required String postId}) async {
    // ✅ مؤقتًا: نطبع الكومنت في الكونسول
    print('📤 Mock SendComment: "$contant" to postId: $postId');
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate delay
    return;
  }
}
