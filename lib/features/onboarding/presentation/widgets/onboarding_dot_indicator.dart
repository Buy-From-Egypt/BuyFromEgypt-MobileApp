import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';

class OnboardingDotIndicator extends StatelessWidget {
  final bool isActive;

  const OnboardingDotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: isActive ? 52 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.c2,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
