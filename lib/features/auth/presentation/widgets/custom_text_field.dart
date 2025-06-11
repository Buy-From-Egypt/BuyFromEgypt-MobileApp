import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solar_icons/solar_icons.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final String? imagePath;
  final bool isPassword;
  final bool isNumber;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    this.imagePath,
    this.isPassword = false,
    this.isNumber = false,
    this.onChanged,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
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
            SvgPicture.asset(widget.imagePath!, width: 24, height: 24)
          else if (widget.icon != null)
            Icon(widget.icon, size: 24, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType ?? (widget.isNumber ? TextInputType.number : TextInputType.text),
              cursorColor: Colors.black,
              obscureText: widget.isPassword ? widget.obscureText : false,
              style: Styles.textStyle14.copyWith(color: AppColors.c6),
              validator: widget.validator,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.label,
                hintStyle: Styles.textStyle14.copyWith(color: AppColors.secondary),
                border: InputBorder.none,
                errorStyle: const TextStyle(height: 0),
              ),
            ),
          ),
          if (widget.isPassword)
            widget.suffixIcon ??
                IconButton(
                  icon: Icon(
                    widget.obscureText
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
