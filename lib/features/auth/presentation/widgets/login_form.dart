import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/CustomTextButton.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/remember.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const LabeledTextField(
              label: 'Email Address',
              imagePath: 'assets/images/Message.svg',
              hintText: 'example@gmail.com',
            ),
            const SizedBox(height: 16),
            const LabeledTextField(
              label: 'Password',
              icon: SolarIconsOutline.lock,
              hintText: '********',
              isPassword: true,
            ),
            const SizedBox(height: 16),
            const Remember(),
            const SizedBox(height: 73),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.home);
              },
              text: 'Sign In',
            ),
            const SizedBox(height: 16),
            const CustomTextButton(
              text1: 'You’re new in here? ',
              text2: 'Create Account',
            ),
          ],
        ),
      ),
    );
  }
}
