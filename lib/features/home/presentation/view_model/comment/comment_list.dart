import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsList extends StatelessWidget {
  final String postId;

  const CommentsList({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentCubit, CommentState>(
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
            return const Center(child: Text('لا توجد تعليقات بعد.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            itemCount: state.comments.length,
            itemBuilder: (context, index) {
              final comment = state.comments[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/theo.jpeg'),
                  ),
                  title: Text(comment.userName),
                  subtitle: Text(comment.content),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
