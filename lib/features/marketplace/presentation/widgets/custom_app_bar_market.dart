import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBarMarket extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomAppBarMarket({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: Styles.textStyle24,
      ),
      actions: [
        const SvgIcon(
          path: 'assets/images/message_markett.svg',
          width: 24,
          height: 24,
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