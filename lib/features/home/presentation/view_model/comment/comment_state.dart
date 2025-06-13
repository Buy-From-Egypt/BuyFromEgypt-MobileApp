import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentModel> comments;
  CommentLoaded(this.comments);
}

class CommentError extends CommentState {
  final String message;
  CommentError(this.message);
}

class CommentSending extends CommentState {}

class CommentSent
    extends CommentState {} // Use this for side effects like clearing input
