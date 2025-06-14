import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_icons/solar_icons.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        titleTextStyle: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            child: Center(
              child: IconButton(
                padding: EdgeInsets.zero,
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
          ),
        ),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}