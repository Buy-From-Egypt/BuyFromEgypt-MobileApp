import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart';

class OnboardingBottomSection extends StatelessWidget {
  final int currentPage;
  final PageController pageController;
  final int onboardingDataLength;

  const OnboardingBottomSection({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.onboardingDataLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onboardingDataLength,
            (index) => OnboardingDotIndicator(isActive: currentPage == index),
          ),
        ),
        const SizedBox(height: 23),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: 327,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                if (currentPage == onboardingDataLength - 1) {
                  Navigator.pushNamed(context, AppRoutes.signUp);
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                currentPage == onboardingDataLength - 1
                    ? "Get Started"
                    : "Next",
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 55),
      ],
    );
  }
}
