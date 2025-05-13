import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.primary,
      child: Center(
          child: SvgIcon(
              path: 'assets/images/profile_icon.svg', width: 15, height: 19.5)),
    );
  }
}
