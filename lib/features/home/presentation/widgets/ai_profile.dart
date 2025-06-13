import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class AiProfileIcon extends StatelessWidget {
  final Color backgroundColor;

  const AiProfileIcon({
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: backgroundColor,
      child: Center(
        child: Image.asset(
          'assets/images/pngegg (55) 1.png',
          width: 52,
          height: 40,
        ),
      ),
    );
  }
}
