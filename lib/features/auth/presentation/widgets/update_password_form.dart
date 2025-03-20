import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class UpdatePasswordForm extends StatelessWidget {
  const UpdatePasswordForm({super.key});

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
              label: 'New Password',
              icon: SolarIconsOutline.lock,
              hintText: '********',
              isPassword: true,
            ),
          const SizedBox(height: 32),
          const LabeledTextField(
              label: 'Confirm new Password',
              icon: SolarIconsOutline.lock,
              hintText: '********',
              isPassword: true,
            ),
          const SizedBox(height: 178),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.successfully);
            },
            text: 'Conform',
          ),
          
        ],
      ),
    );
  }
}