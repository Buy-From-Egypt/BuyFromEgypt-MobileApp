import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSearchBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent',
                  style: Styles.textStyle16.copyWith(
                      color: AppColors.danger, fontWeight: FontWeight.w600),
                ),
                Text(
                  'See all',
                  style: Styles.textStyle14.copyWith(color: AppColors.c5),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              padding: const EdgeInsets.only(bottom: 16),
              itemBuilder: (context, index) => const CustomSearchItem(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchItem extends StatelessWidget {
  const CustomSearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const ProfileImage(
                path: 'assets/images/samsun.png',
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 16),
              Text(
                'Samsung Electronics',
                style: Styles.textStyle14.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Icon(
            SolarIconsOutline.menuDots,
            size: 24,
            color: AppColors.primary,
          )
        ],
      ),
    );
  }
}
