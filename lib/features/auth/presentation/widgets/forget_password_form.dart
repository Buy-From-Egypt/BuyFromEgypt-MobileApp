import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/CustomTextButton.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

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
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LabeledTextField(
            label: 'Email Address',
            imagePath: 'assets/images/Message.svg',
            hintText: 'example@gmail.com',
          ),
          const SizedBox(height: 28),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.otpForgetPassword);
            },
            text: 'Send OTP',
          ),
          const SizedBox(height: 16),
          const CustomTextButton(
            text1: 'Remembered it? ',
            text2: 'Back to Login',
          ),
        ],
      ),
    );
  }
}
