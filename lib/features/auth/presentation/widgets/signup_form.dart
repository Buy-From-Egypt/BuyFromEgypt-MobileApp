import 'package:buy_from_egypt/features/auth/presentation/widgets/CustomTextButton.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class SignUpForm extends StatelessWidget {
  final VoidCallback onSignUpPressed;

  const SignUpForm({super.key, required this.onSignUpPressed});

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 327, child: CustomTabBar()),
              const SizedBox(height: 24),
              const LabeledTextField(
                label: 'Full name',
                icon: SolarIconsOutline.user,
                hintText: 'Your Name',
              ),
              const SizedBox(height: 16),
              const LabeledTextField(
                label: 'Email Address',
                imagePath: 'assets/images/Messages.png',
                hintText: 'example@gmail.com',
              ),
              const SizedBox(height: 16),
              const LabeledTextField(
                label: 'Password',
                icon: SolarIconsOutline.lock,
                hintText: '********',
                isPassword: true,
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: onSignUpPressed,
                text: 'Sign Up',
              ),
              const SizedBox(height: 16),
              const CustomTextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
