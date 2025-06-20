import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_state.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_header.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_input_bar_im.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_item.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/dark_back_button.dart';

class CommentViewIm extends StatelessWidget {
  final String postId;

  const CommentViewIm({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(50),
              child: const DarkBackButton(),
            ),
          ),
          title: const Text('Comments', style: Styles.textStyle16400),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<CommentCubit, CommentState>(
            builder: (context, state) {
              final count = state is CommentLoaded ? state.comments.length : 0;
              return CommentHeader(commentCount: count);
            },
          ),
          Expanded(
            child: BlocConsumer<CommentCubit, CommentState>(
              listener: (context, state) {
                if (state is CommentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CommentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CommentLoaded) {
                  if (state.comments.isEmpty) {
                    return const Center(
                      child: Text(
                        'No comments yet.\nBe the first to comment!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) =>
                        CommentItem(comment: state.comments[index]),
                  );
                } else if (state is CommentError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const Divider(thickness: 1, height: 1),
          CommentInputBarIm(
            onSend: (content) {
              context.read<CommentCubit>().sendComment(content, postId);
            },
          ),
        ],
      ),
    );
  }
}
