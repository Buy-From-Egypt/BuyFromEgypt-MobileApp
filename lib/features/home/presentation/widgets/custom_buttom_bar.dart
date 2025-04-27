import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final VoidCallback onExpandLessTap;

  const CustomBottomBar({super.key, required this.onExpandLessTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.c4, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const SvgIcon(
                  path: 'assets/images/black image.svg',
                  width: 28.67,
                  height: 28.67),
              const SizedBox(width: 10),
              const SvgIcon(
                  path: 'assets/images/black video.svg',
                  width: 28.67,
                  height: 28.67),
              const SizedBox(width: 10),
              const SvgIcon(
                  path: 'assets/images/black calendar.svg',
                  width: 31,
                  height: 31),
              const SizedBox(width: 10),
              const SvgIcon(
                  path: 'assets/images/Black link.svg', width: 17, height: 17),
              const Spacer(),
              GestureDetector(
                onTap: onExpandLessTap,
                child: Icon(
                  Icons.expand_less_rounded,
                  size: 40,
                  color: AppColors.c5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
