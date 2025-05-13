import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_header.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_input_bar_im.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/comment_item.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/commrnt_input_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/dark_back_button.dart';
import 'package:flutter/material.dart';

class CommentViewIm extends StatelessWidget {
  const CommentViewIm({super.key});

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
              child: DarkBackButton(),
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
          const CommentHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: 5,
              itemBuilder: (context, index) => const CommentItem(),
            ),
          ),
          const Divider(thickness: 1, height: 1),
          const CommentInputBarIm(),
        ],
      ),
    );
  }
}
