import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class SuccessfullyView extends StatelessWidget {
  const SuccessfullyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Rectangle.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                SolarIconsOutline.checkCircle,
                color: AppColors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Password Updated!',
              style: Styles.textStyle22.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Your password has been successfully updated. You can now log in with your new password.',
                textAlign: TextAlign.center,
                style: Styles.textStyle14.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.auth,
                    (route) => false,
                  );
                },
                text: 'Back to Login',
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
