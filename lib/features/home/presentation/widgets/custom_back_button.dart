import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  final Color? borderColor;
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.borderColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        Navigator.pop(context);
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.c5),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/back_f.svg',
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
} 