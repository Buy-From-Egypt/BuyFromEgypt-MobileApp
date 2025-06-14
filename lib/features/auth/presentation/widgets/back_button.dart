import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_icons/solar_icons.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary,
          width: 1,
        ),
      ),
      child: Center(
        child: IconButton(
          icon: const FaIcon(
            SolarIconsOutline.arrowLeft,
            size: 18,
            color: AppColors.primary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
