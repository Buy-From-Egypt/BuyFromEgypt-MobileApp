import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PreferenceHeader extends StatelessWidget {
  const PreferenceHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 73,
          ),
          Text(
            'Smart Sourcing Starts Here!',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Customize your experience and find the right products',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w500,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }
}