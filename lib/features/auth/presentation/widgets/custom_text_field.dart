import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final String? imagePath;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    this.imagePath,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.c4),
      ),
      child: Row(
        children: [
          const SizedBox(width: 24),
          if (widget.imagePath != null)
            Image.asset(widget.imagePath!, width: 24, height: 24)
          else if (widget.icon != null)
            Icon(widget.icon, size: 24, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              cursorColor: Colors.black,
              obscureText: widget.isPassword ? obscureText : false,
              style: Styles.textStyle14.copyWith(color: AppColors.c6),
              decoration: InputDecoration(
                hintText: widget.label,
                hintStyle:
                    Styles.textStyle14.copyWith(color: AppColors.secondary),
                border: InputBorder.none,
              ),
            ),
          ),
          if (widget.isPassword)
            IconButton(
              icon: Icon(
                obscureText
                    ? SolarIconsOutline.eyeClosed
                    : SolarIconsOutline.eye,
                color: AppColors.primary,
              ),
              onPressed: () => setState(() {
                obscureText = !obscureText;
              }),
            ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
