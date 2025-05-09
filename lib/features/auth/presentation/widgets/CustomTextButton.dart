import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text1, text2;
  final VoidCallback? onPressed;
  const CustomTextButton({
    super.key,
    required this.text1,
    required this.text2,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text.rich(
        TextSpan(
          text: text1,
          style: Styles.textStyle14.copyWith(color: AppColors.c7),
          children: [
            TextSpan(
              text: text2,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
