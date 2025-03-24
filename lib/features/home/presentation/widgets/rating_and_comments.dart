import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RatingAndComments extends StatelessWidget {
  const RatingAndComments({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24 , bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '300 Rate',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              height: 1.42,
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            radius: 2.5,
            backgroundColor: AppColors.primary,
          ),
          SizedBox(width: 8),
          Text(
            '50 Comment',
            style: TextStyle(
              color: Color(0xFF3B3C36),
              fontSize: 12,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              height: 1.42,
            ),
          ),
        ],
      ),
    );
  }
}
