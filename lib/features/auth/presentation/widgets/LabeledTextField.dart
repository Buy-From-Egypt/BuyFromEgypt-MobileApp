import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_text_field_for_phone.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class LabeledTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final String? imagePath;
  final String hintText;
  final bool isPassword;
  final bool isNumber;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const LabeledTextField({
    super.key,
    required this.label,
    this.icon,
    this.imagePath,
    required this.hintText,
    this.isPassword = false,
    this.isNumber = false,
    this.onChanged,
    required this.validator,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  @override
  Widget build(BuildContext context) {
    final isPhone = widget.label.toLowerCase() == 'phone number';

    return SizedBox(
      width: 327,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Styles.textStyle14.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          isPhone
              ? CustomTextFieldForPhone(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  isNumber: widget.isNumber,
                  label: widget.hintText,
                )
              : CustomTextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  label: widget.hintText,
                  icon: widget.icon,
                  imagePath: widget.imagePath,
                  isPassword: widget.isPassword,
                  isNumber: widget.isNumber,
                  obscureText: widget.obscureText,
                  suffixIcon: widget.suffixIcon,
                  keyboardType: widget.keyboardType,
                  validator: widget.validator,
                ),
        ],
      ),
    );
  }
}
