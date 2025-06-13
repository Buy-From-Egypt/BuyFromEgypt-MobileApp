import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class EnterMessage extends StatelessWidget {
  const EnterMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60, // Set desired height for the input
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type Message',
                hintStyle: Styles.textStyle16c7,
                filled: true,
                fillColor: AppColors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                suffixIcon: const Padding(
                  padding:
                      EdgeInsets.only(right: 24), // Add spacing around icon
                  child: SvgIcon(
                    path: 'assets/images/links.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 32,
                  minWidth: 32,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.c7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.c7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.c7),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 48,
          width: 48,
          decoration: const BoxDecoration(
            color: AppColors.c7,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgIcon(
              path: 'assets/images/sendd.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}
