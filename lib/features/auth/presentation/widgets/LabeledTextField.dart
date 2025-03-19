import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? imagePath;
  final String hintText;
  final bool isPassword;

  const LabeledTextField({
    super.key,
    required this.label,
    this.icon,
    this.imagePath,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Styles.textStyle14.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            label: hintText,
            icon: icon,
            imagePath: imagePath,
            isPassword: isPassword,
          ),
        ],
      ),
    );
  }
}
