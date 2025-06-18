import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/comment/comment_model.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_header.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_item.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/commrnt_input_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/dark_back_button.dart';
import 'package:flutter/material.dart';

class CommentViewEx extends StatelessWidget {
  const CommentViewEx({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية
    final dummyComments = List.generate(5, (index) {
      /*return CommentModel(
        id: '$index',
        contant: 'This is comment number $index',
        userName: 'User $index',
        createdAt: DateTime.now().subtract(Duration(hours: index)),
        rating: 4,
        likes: 10 + index,
        dislikes: 1,
      );*/
    });

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
          title: const Text(
            'Comments',
            style: Styles.textStyle16400,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          /*  const CommentHeader(),*/
          /*    Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: dummyComments.length,
              itemBuilder: (context, index) =>
                  CommentItem(comment: dummyComments[index]),
            ),
          ),*/
          const Divider(thickness: 1, height: 1),
          // const CommentInputBar(),
        ],
      ),
    );
  }
}
