import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomPostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomPostAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFCDD1D6),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.primary,
              size: 20,
            ),
          ),
        ),
      ),
      title: const Text(
        'Create Post',
        style: Styles.textStyle16400,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            width: 56,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.primary,
            ),
            child: const Text(
              'Post',
              style: Styles.textStyle12w,
            ),
          ),
        ),
      ],
    );
  }
}
