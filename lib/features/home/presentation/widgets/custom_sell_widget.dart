import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/company_profile.dart/presentation/views/company_info_screen.dart';
import 'package:buy_from_egypt/features/home/presentation/views/create_post_ex.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSellWidget extends StatelessWidget {
  const CustomSellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.c4, width: 1),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CompanyInfoScreen(), // <- Your target screen
                ),
              );
            },
            child: const ProfileImage(
              path: 'assets/images/theo.jpeg',
              width: 48,
              height: 48,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CreatePostEx(), // <- Your target screen
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 38,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.c4, width: 1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Text(
                      'What you are selling ?',
                      style:
                          Styles.textStyle14.copyWith(color: AppColors.primary),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/Gallery Minimalistic.svg',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/images/Clapperboard Play.svg',
                      width: 18,
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
