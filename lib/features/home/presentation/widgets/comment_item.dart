import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';

class CommentItem extends StatefulWidget {
  final CommentModel comment;

  const CommentItem({super.key, required this.comment});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  late bool isRated;
  late double rating;
  late bool isLiked;
  late bool isDisliked;
  late int likes;
  late int dislikes;

  @override
  void initState() {
    super.initState();
    isRated = widget.comment.isRated;
    rating = widget.comment.rating.toDouble();
    isLiked = widget.comment.isLiked;
    isDisliked = widget.comment.isDisliked;
    likes = widget.comment.likes;
    dislikes = widget.comment.dislikes;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/theo.jpeg'),
              ),
              SizedBox(width: width * 0.025),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.comment.userName,
                          style: Styles.textStyle14pr),
                      SizedBox(width: width * 0.02),
                      Text(_getTimeAgo(widget.comment.createdAt),
                          style: Styles.textStyle12700),
                    ],
                  ),
                  SizedBox(height: width * 0.01),
                  RatingBar.builder(
                    initialRating: rating.clamp(0, 5),
                    minRating: 0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: width * 0.05,
                    allowHalfRating: false,
                    unratedColor: AppColors.yellow.withOpacity(0.3),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: AppColors.yellow),
                    onRatingUpdate: (value) {
                      setState(() {
                        if (rating == value) {
                          rating = 0;
                          isRated = false;
                        } else {
                          rating = value;
                          isRated = true;
                        }
                      });
                      context
                          .read<CommentCubit>()
                          .rateComment(widget.comment.id, rating);
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          Text(widget.comment.content, style: Styles.textStyle14pr),
          SizedBox(height: width * 0.02),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isLiked) {
                      isLiked = false;
                      likes--;
                    } else {
                      isLiked = true;
                      isDisliked = false;
                      likes++;
                      if (dislikes > 0) dislikes--;
                    }
                  });
                  context.read<CommentCubit>().likeComment(widget.comment.id);
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/Vector.svg', width: 20),
                    SizedBox(width: width * 0.01),
                    Text('$likes', style: Styles.textStyle14pr),
                  ],
                ),
              ),
              SizedBox(width: width * 0.04),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isDisliked) {
                      isDisliked = false;
                      dislikes--;
                    } else {
                      isDisliked = true;
                      isLiked = false;
                      dislikes++;
                      if (likes > 0) likes--;
                    }
                  });
                  context
                      .read<CommentCubit>()
                      .dislikeComment(widget.comment.id);
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/dislike.svg', width: 20),
                    SizedBox(width: width * 0.01),
                    Text('$dislikes', style: Styles.textStyle14pr),
                  ],
                ),
              ),
              SizedBox(width: width * 0.04),
              GestureDetector(
                onTap: () {
                  context.read<CommentCubit>().setReplyingTo(widget.comment);
                },
                child: const Text('Reply', style: Styles.textStyle14pr),
              ),
            ],
          ),
          if (widget.comment.replies.isNotEmpty) ...[
            SizedBox(height: 10),
            ...widget.comment.replies.map((reply) {
              return Padding(
                padding: EdgeInsets.only(left: width * 0.12, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reply.userName,
                        style: Styles.textStyle14pr.copyWith(fontSize: 13)),
                    SizedBox(height: 4),
                    Text(reply.content, style: Styles.textStyle12700),
                    SizedBox(height: 6),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inMinutes < 60) return "${duration.inMinutes} min ago";
    if (duration.inHours < 24) return "${duration.inHours} hour ago";
    return "${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ago";
  }
}
