import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solar_icons/solar_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/buy from egypt logo m 1.png",
                width: 38,
                height: 14,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Buy From Egypt',
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        SvgPicture.asset(
          'assets/images/messages.svg',
          height: 24,
          width: 24,
        ),
        const SizedBox(width: 12),
        IconButton(
          icon: Icon(SolarIconsOutline.bookmark),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.save),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.search);
          },
          child: SvgPicture.asset(
            'assets/images/search.svg',
            height: 24,
            width: 24,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
