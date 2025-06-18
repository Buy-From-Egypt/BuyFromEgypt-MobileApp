import 'dart:ui';

import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/header_of_card.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/rate_comment_share.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/rating_and_comments.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final PostModel post;

  const Post({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    print('🔥 post.postId inside Post widget: ${post.postId}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderOfCard(post: post),

        // ✅ description from model
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Text(
            post.content,
            style: const TextStyle(fontSize: 14),
          ),
        ),

        // ✅ fixed image for now
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: Container(
            width: double.infinity,
            height: 218,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/unsplash_whIInzoSukc.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const RatingAndComments(),

        // ✅ Use postId
        RateCommentShare(postId: post.postId),

        const Divider(thickness: 4),
      ],
    );
  }
}
