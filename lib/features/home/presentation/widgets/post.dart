import 'package:buy_from_egypt/features/home/presentation/widgets/description.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/header_of_card.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/rate_comment_share.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/rating_and_comments.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderOfCard(),
        const Description(),
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
        const RateCommentShare(),
        const Divider(
          thickness: 4,
        )
      ],
    );
  }
}
