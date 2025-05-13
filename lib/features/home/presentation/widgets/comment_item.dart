import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/theo.jpeg'),
              ),
              SizedBox(width: width * 0.025),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Mohamed Talaat',
                        style: Styles.textStyle14pr,
                      ),
                      SizedBox(width: width * 0.02),
                      const Text(
                        '5 hour ago',
                        style: Styles.textStyle12700,
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.01),
                  SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating: 4,
                    size: width * 0.05,
                    filledIconData: Icons.star_rounded,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border_rounded,
                    color: AppColors.yellow,
                    borderColor: AppColors.yellow,
                    spacing: 2.0,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          const Text(
            'It is a long established fact that a reader will be distracted...',
            style: Styles.textStyle14pr,
          ),
          SizedBox(height: width * 0.02),
          Row(
            children: [
              SvgPicture.asset('assets/images/Vector.svg', width: 20),
              SizedBox(width: width * 0.01),
              const Text('42', style: Styles.textStyle14pr),
              SizedBox(width: width * 0.04),
              SvgPicture.asset('assets/images/dislike.svg', width: 20),
              SizedBox(width: width * 0.01),
              const Text('3', style: Styles.textStyle14pr),
              SizedBox(width: width * 0.04),
              const Text('Reply', style: Styles.textStyle14pr),
            ],
          ),
        ],
      ),
    );
  }
}
