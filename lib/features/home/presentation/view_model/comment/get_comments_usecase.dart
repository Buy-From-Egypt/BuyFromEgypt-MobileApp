// get_comments_use_case.dart
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository.dart';

abstract class GetCommentsUseCase {
  Future<List<CommentModel>> call(String postId);
}

class GetCommentsUseCaseImpl implements GetCommentsUseCase {
  final CommentRepository repository;

  GetCommentsUseCaseImpl(this.repository);

  @override
  Future<List<CommentModel>> call(String postId) async {
    try {
      return await repository.getComments(postId);
    } catch (e) {
      // يمكنك تسجيل الخطأ هنا أو معالجته بطريقة أخرى
      rethrow;
    }
  }
}
