import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';

class ProductDotIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const ProductDotIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              count,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: index == currentIndex ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: index == currentIndex
                      ? AppColors.primary
                      : AppColors.background,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
