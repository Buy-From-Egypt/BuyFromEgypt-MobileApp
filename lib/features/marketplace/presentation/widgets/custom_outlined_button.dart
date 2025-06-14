import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Widget? icon;
  final Color borderColor;
  final Color textColor;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.borderColor = AppColors.primary,
    this.textColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                height: 1.56,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              icon!,
            ]
          ],
        ),
      ),
    );
  }
}
