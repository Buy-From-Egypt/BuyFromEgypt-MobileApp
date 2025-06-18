import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_repository_iml.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

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

  List<CommentModel> get comments => List.unmodifiable(_comments);

  Future<void> fetchComments(String postId) async {
    emit(CommentLoading());
    try {
      final comments = await getCommentsUseCase(postId);
      _comments = comments;
      emit(CommentLoaded(List.from(_comments)));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  /// إرسال تعليق جديد
  void sendComment(String content, String postId) async {
    if (content.trim().isEmpty) {
      emit(CommentError('لا يمكن إرسال تعليق فارغ'));
      return;
    }

    emit(CommentSending());

    final tempId = DateTime.now().microsecondsSinceEpoch.toString();
    final tempComment = CommentModel(
      id: tempId,
      content: content,
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
      await sendCommentUseCase(content: content, postId: postId);
      await _refreshComments(postId);
    } catch (e) {
      _comments.removeWhere((c) => c.id == tempId);
      emit(CommentLoaded(List.from(_comments)));
      emit(CommentError(_mapSendError(e)));

      Future.delayed(const Duration(seconds: 2), () {
        if (!isClosed) emit(CommentLoaded(List.from(_comments)));
      });
    }
  }

  /// تعيين تعليق للرد عليه
  void setReplyingTo(CommentModel? comment) {
    replyingTo = comment;
    emit(CommentLoaded(List.from(_comments)));
  }

  void cancelReply() {
    replyingTo = null;
    emit(ReplyCanceled());
    emit(CommentLoaded(List.from(_comments)));
  }

  /// الرد على تعليق (محلي فقط)
  void replyToComment({
    required String parentCommentId,
    required String replyText,
  }) {
    if (replyText.trim().isEmpty) {
      emit(CommentError('لا يمكن إرسال رد فارغ'));
      return;
    }

    final parentIndex = _comments.indexWhere((c) => c.id == parentCommentId);
    if (parentIndex != -1) {
      final reply = CommentModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        content: replyText,
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

      _comments[parentIndex].replies.add(reply);
      replyingTo = null;
      emit(CommentLoaded(List.from(_comments)));
    }
  }

  /// إعجاب بتعليق
  void likeComment(String commentId) {
    final index = _comments.indexWhere((c) => c.id == commentId);
    if (index == -1) return;

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

  /// عدم إعجاب بتعليق
  void dislikeComment(String commentId) {
    final index = _comments.indexWhere((c) => c.id == commentId);
    if (index == -1) return;

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

  /// تقييم تعليق
  void rateComment(String commentId, double rating) {
    final index = _comments.indexWhere((c) => c.id == commentId);
    if (index == -1) return;

    final comment = _comments[index];
    comment.rating = rating.toInt();
    comment.isRated = rating > 0;

    emit(CommentLoaded(List.from(_comments)));
  }

  Future<void> _refreshComments(String postId) async {
    try {
      final comments = await getCommentsUseCase(postId);
      _comments = comments;
      emit(CommentLoaded(List.from(_comments)));
    } catch (e) {
      debugPrint('Error in _refreshComments: $e');
    }
  }

  /// إغلاق
  @override
  Future<void> close() {
    print('🧹 CommentCubit closed');
    return super.close();
  }

  /// معالجة الأخطاء عند التحميل
  String _mapLoadError(Object e) {
    final error = e.toString();
    if (error.contains('Network error')) return 'تحقق من اتصال الإنترنت';
    if (error.contains('404')) return 'خدمة التعليقات غير متاحة حالياً';
    if (error.contains('500')) return 'خطأ في الخادم، حاول مرة أخرى';
    return 'فشل في تحميل التعليقات';
  }

  /// معالجة الأخطاء عند الإرسال
  String _mapSendError(Object e) {
    final error = e.toString();
    if (error.contains('Network error')) return 'تحقق من اتصال الإنترنت';
    if (error.contains('Unauthorized'))
      return 'انتهت صلاحية الجلسة، سجل دخول مرة أخرى';
    if (error.contains('Bad request')) return 'خطأ في بيانات التعليق';
    return 'فشل في إرسال التعليق';
  }

  /// ✅ دالة factory لإنشاء cubit مع repo جاهز
  static CommentCubit create() {
    final dio = Dio();
    final logger = Logger();
    final repo = CommentRepositoryImpl(logger);

    return CommentCubit(
      getCommentsUseCase: GetCommentsUseCaseImpl(repo),
      sendCommentUseCase: SendCommentUseCaseImpl(repo),
    );
  }
}
