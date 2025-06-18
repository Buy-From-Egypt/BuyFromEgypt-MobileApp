import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_cubit.dart';

class CommentInputBar extends StatefulWidget {
  final String postId;

  const CommentInputBar({super.key, required this.postId});

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final replyingTo = context.watch<CommentCubit>().replyingTo;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, -4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (replyingTo != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                        child: Text("Replying to ${replyingTo.userName}",
                            style: Styles.textStyle14c5)),
                    GestureDetector(
                      onTap: () =>
                          context.read<CommentCubit>().setReplyingTo(null),
                      child: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0)
                  .copyWith(top: 8, bottom: 12),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/theo.jpeg'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Add Comment.....',
                        hintStyle: Styles.textStyle14c5,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/image.svg'),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/images/link.svg'),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/images/video.svg'),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/images/calendar.svg'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      final text = controller.text.trim();
                      if (text.isEmpty) return;

                      final cubit = context.read<CommentCubit>();
                      if (cubit.replyingTo != null) {
                        cubit.replyToComment(
                          parentCommentId: cubit.replyingTo!.id,
                          replyText: text,
                        );
                        cubit.setReplyingTo(null);
                      } else {
                        cubit.sendComment(text, widget.postId);
                      }
                      controller.clear();
                    },
                    child: const Text('Send', style: Styles.textStyle18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
