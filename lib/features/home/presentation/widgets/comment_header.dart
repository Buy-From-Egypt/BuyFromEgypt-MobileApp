import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';

class CommentHeader extends StatelessWidget {
  const CommentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Row(
        children: [
          const Text('Comments', style: Styles.textStyle12pr),
          const SizedBox(width: 6),
          Container(
            width: 35,
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
          const SizedBox(width: 4),
          Icon(
            Icons.expand_more_rounded,
            size: 16, // adjust based on your UI
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
