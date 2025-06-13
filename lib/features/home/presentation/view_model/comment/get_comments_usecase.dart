import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository.dart';

abstract class GetCommentsUseCase {
  Future<List<CommentModel>> call(String postId);
}

class GetCommentsUseCaseImpl implements GetCommentsUseCase {
  final CommentRepository repository;

  static final Map<String, List<CommentModel>> _mockCommentsMap = {};

  GetCommentsUseCaseImpl(this.repository);

  @override
  Future<List<CommentModel>> call(String postId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!_mockCommentsMap.containsKey(postId)) {
      _mockCommentsMap[postId] = [
        CommentModel(
          id: '1',
          userName: 'Ahmed Hassan',
          contant: 'This is really helpful, thank you!',
          createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
          rating: 0,
          likes: 0,
          dislikes: 0,
          isLiked: false,
          isDisliked: false,
          isRated: false,
        ),
        CommentModel(
          id: '2',
          userName: 'Sara Mohamed',
          contant: 'Can you post more like this?',
          createdAt: DateTime.now().subtract(const Duration(minutes: 6)),
          rating: 0,
          likes: 0,
          dislikes: 0,
          isLiked: false,
          isDisliked: false,
          isRated: false,
        ),
      ];
    }

    return _mockCommentsMap[postId]!;
  }

  static void addMockComment({
    required String postId,
    required String contant,
  }) {
    final list = _mockCommentsMap[postId] ??= [];
    list.insert(
      0,
      CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: 'You',
        contant: contant,
        createdAt: DateTime.now(),
        rating: 0, // ضروري
        likes: 0,
        dislikes: 0,
        isRated: false, // ضروري
        isLiked: false,
        isDisliked: false,
      ),
    );
  }
}
