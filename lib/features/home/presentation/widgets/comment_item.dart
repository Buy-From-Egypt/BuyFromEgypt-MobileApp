import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
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
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Mohamed Talaat',
                        style: Styles.textStyle14pr,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '5 hour ago',
                        style: Styles.textStyle12700,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating: 4,
                    size: 20.0,
                    filledIconData: Icons.star_rounded,
                    halfFilledIconData: Icons.star_half,
                    color: AppColors.yellow,
                    borderColor: AppColors.yellow,
                    spacing: 2.0,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'It is a long established fact that a reader will be distracted...',
            style: Styles.textStyle14pr,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset('assets/images/Vector.svg'),
              const SizedBox(width: 4),
              const Text('42', style: Styles.textStyle14pr),
              const SizedBox(width: 16),
              SvgPicture.asset('assets/images/dislike.svg'),
              const SizedBox(width: 4),
              const Text('3', style: Styles.textStyle14pr),
              const SizedBox(width: 16),
              const Text('Reply', style: Styles.textStyle14pr),
            ],
          ),
        ],
      ),
    );
  }
}
