import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';

class CommentHeader extends StatelessWidget {
  const CommentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 8),
      child: Row(
        children: [
          const Text('Comments', style: Styles.textStyle12pr),
          SizedBox(width: width * 0.015),
          Container(
            width: width * 0.09,
            height: 21,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('50', style: Styles.textStyle9),
          ),
          const Spacer(),
          const Text('Most recent', style: Styles.textStyle12pr),
          SizedBox(width: width * 0.01),
          Icon(
            Icons.expand_more_rounded,
            size: width * 0.04,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
