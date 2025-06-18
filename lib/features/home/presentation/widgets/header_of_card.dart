import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';
import 'package:flutter/material.dart';
import 'user_section.dart';
import 'action_buttons.dart';

class HeaderOfCard extends StatelessWidget {
  const HeaderOfCard({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserSection(
                timeAgo: post.createdAt,
              ),
              ActionButtons(),
            ],
          ),
        ],
      ),
    );
  }
}
