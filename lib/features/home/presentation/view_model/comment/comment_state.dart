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

class CommentSent extends CommentState {}

class ReplyCanceled extends CommentState {}

class CommentSending extends CommentState {}
