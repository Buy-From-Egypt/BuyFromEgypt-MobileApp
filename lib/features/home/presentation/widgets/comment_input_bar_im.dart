import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_state.dart';

class CommentInputBarIm extends StatefulWidget {
  final Function(String) onSend;

  const CommentInputBarIm({
    Key? key,
    required this.onSend,
  }) : super(key: key);

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
    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is CommentSent) {
          _commentController.clear();
        }
      },
      child: Container(
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
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/theo.jpeg'),
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      hintText: 'Add a comment...',
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
                    final bool isSending = state is CommentSending;
                    final bool canSend = _hasText && !isSending;

                    return IconButton(
                      icon: isSending
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            )
                          : Icon(Icons.send,
                              color: canSend ? Colors.blue : Colors.grey[400]),
                      onPressed: canSend
                          ? () {
                              widget.onSend(_commentController.text.trim());
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
    );
  }
}
