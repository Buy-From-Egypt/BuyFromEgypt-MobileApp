import 'package:flutter_bloc/flutter_bloc.dart';
import 'comment_model.dart';
import 'comment_state.dart';
import 'get_comments_usecase.dart';
import 'send_comment_usecase.dart';

class CommentCubit extends Cubit<CommentState> {
  final GetCommentsUseCase getCommentsUseCase;
  final SendCommentUseCase sendCommentUseCase;

  CommentCubit({
    required this.getCommentsUseCase,
    required this.sendCommentUseCase,
  }) : super(CommentInitial());

  List<CommentModel> _comments = [];
  CommentModel? replyingTo;

  List<CommentModel> get comments => List.from(_comments);

  void fetchComments(String postId) async {
    emit(CommentLoading());
    await _loadComments(postId);
  }

  Future<void> _loadComments(String postId) async {
    try {
      _comments = await getCommentsUseCase(postId);
      emit(CommentLoaded(List.from(_comments)));
    } catch (e) {
      emit(CommentError('Failed to load comments: $e'));
    }
  }

  void setReplyingTo(CommentModel? comment) {
    replyingTo = comment;
    emit(CommentLoaded(List.from(_comments)));
  }

  void sendComment(String contant, String postId) async {
    emit(CommentSending());

    final tempId = DateTime.now().microsecondsSinceEpoch.toString();
    final tempComment = CommentModel(
      id: tempId,
      contant: contant,
      userName: 'You',
      createdAt: DateTime.now(),
      rating: 0,
      likes: 0,
      dislikes: 0,
      isLiked: false,
      isDisliked: false,
      isRated: false,
      replies: [],
    );

    _comments.insert(0, tempComment);
    emit(CommentLoaded(List.from(_comments)));

    try {
      await sendCommentUseCase(contant: contant, postId: postId);
      await _loadComments(postId);
    } catch (e) {
      _comments.removeWhere((comment) => comment.id == tempId);
      emit(CommentLoaded(List.from(_comments)));
      emit(CommentError('Failed to send comment: $e'));
    }
  }

  void likeComment(String commentId) {
    final index = _comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      final comment = _comments[index];
      if (comment.isLiked) {
        comment.likes--;
        comment.isLiked = false;
      } else {
        comment.likes++;
        comment.isLiked = true;
        if (comment.isDisliked) {
          comment.dislikes--;
          comment.isDisliked = false;
        }
      }
      emit(CommentLoaded(List.from(_comments)));
    }
  }

  void dislikeComment(String commentId) {
    final index = _comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      final comment = _comments[index];
      if (comment.isDisliked) {
        comment.dislikes--;
        comment.isDisliked = false;
      } else {
        comment.dislikes++;
        comment.isDisliked = true;
        if (comment.isLiked) {
          comment.likes--;
          comment.isLiked = false;
        }
      }
      emit(CommentLoaded(List.from(_comments)));
    }
  }

  void rateComment(String commentId, double rating) {
    final index = _comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      final comment = _comments[index];
      comment.rating = rating.toInt();
      comment.isRated = rating > 0;
      emit(CommentLoaded(List.from(_comments)));
    }
  }

  void replyToComment({
    required String parentCommentId,
    required String replyText,
  }) {
    final index = _comments.indexWhere((c) => c.id == parentCommentId);
    if (index != -1) {
      final reply = CommentModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        contant: replyText,
        userName: 'You',
        createdAt: DateTime.now(),
        rating: 0,
        likes: 0,
        dislikes: 0,
        isLiked: false,
        isDisliked: false,
        isRated: false,
        replies: [],
      );
      _comments[index].replies.add(reply);
      emit(CommentLoaded(List.from(_comments)));
    }
  }
}
