import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_icons/solar_icons.dart';

class OnboardingAppBar extends StatelessWidget {
  final int currentPage;
  final PageController pageController;
  final int onboardingDataLength;

  const OnboardingAppBar({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.onboardingDataLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 63),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentPage == 0
              ? const SizedBox(width: 260)
              : GestureDetector(
                  onTap: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.c5,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: FaIcon(
                        SolarIconsOutline.arrowLeft,
                        size: 24,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
          if (currentPage != onboardingDataLength - 1)
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signUp);
              },
              child: Text(
                "Skip",
                style: Styles.textStyle16.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
