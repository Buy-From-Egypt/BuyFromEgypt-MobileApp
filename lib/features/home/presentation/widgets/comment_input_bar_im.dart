import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_state.dart';

class CommentInputBarIm extends StatefulWidget {
  final Function(String) onSend;

  const CommentInputBarIm({Key? key, required this.onSend}) : super(key: key);

  @override
  State<CommentInputBarIm> createState() => _CommentInputBarImState();
}

class _CommentInputBarImState extends State<CommentInputBarIm> {
  final TextEditingController _commentController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _commentController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _commentController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _commentController.removeListener(_onTextChanged);
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is CommentSent || state is ReplyCanceled) {
          _commentController.clear();
        }
      },
      builder: (context, state) {
        final replyingTo = context.read<CommentCubit>().replyingTo;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (replyingTo != null)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Replying to ${replyingTo.userName}',
                        style: Styles.textStyle14pr,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        context.read<CommentCubit>().cancelReply();
                      },
                    ),
                  ],
                ),
              ),
            Container(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/theo.jpeg'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            hintText: replyingTo != null
                                ? 'Reply to ${replyingTo.userName}...'
                                : 'Add a comment...',
                            hintStyle: Styles.textStyle14c5,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      const SizedBox(width: 8),
                      BlocBuilder<CommentCubit, CommentState>(
                        builder: (context, state) {
                          final isSending = state is CommentSending;
                          final canSend = _hasText && !isSending;

                          return IconButton(
                            icon: isSending
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                    ),
                                  )
                                : Icon(Icons.send,
                                    color: _commentController.text
                                            .trim()
                                            .isNotEmpty
                                        ? Colors.blue
                                        : Colors.grey[400]),
                            onPressed: _commentController.text
                                        .trim()
                                        .isNotEmpty &&
                                    !isSending
                                ? () {
                                    FocusScope.of(context)
                                        .unfocus(); // إغلاق الكيبورد
                                    widget
                                        .onSend(_commentController.text.trim());
                                  }
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
