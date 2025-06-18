import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/get_comments_usecase.dart';

class GetCommentsUseCaseImpl implements GetCommentsUseCase {
  final CommentRepository _repository;

  GetCommentsUseCaseImpl(this._repository);

  @override
  Future<List<CommentModel>> call(String postId) async {
    return _repository.getComments(postId);
  }
}
