import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DarkBackButton extends StatelessWidget {
  const DarkBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.c5, // You can adjust this color
          width: 1.5,
        ),
      ),
      child: const Icon(
        Icons.arrow_back,
        color: AppColors.primary,
        size: 20,
      ),
    );
  }
}
