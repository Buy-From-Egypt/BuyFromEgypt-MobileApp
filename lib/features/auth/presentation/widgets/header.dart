import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/back_button.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title, description;
  const Header({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Rectangle.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: CustomBackButton(
              iconColor: AppColors.background,
              borderColor: AppColors.background,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      Styles.textStyle22.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: Styles.textStyle14.copyWith(color: AppColors.c7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
