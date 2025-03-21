import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key, required Null Function() onClose});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: Center(
              child: Container(
                width: screenWidth * 0.93, 
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Verify Your Account',
                      style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      backgroundColor: AppColors.c4,
                      radius: 40,
                      child: ClipOval(
                        child: Icon(
                          SolarIconsBold.chatUnread,
                          color: AppColors.primary,
                          size: 48,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      "Enter the 4-digit verification code we have sent to",
                      textAlign: TextAlign.center,
                      style: Styles.textStyle14.copyWith(
                        color: AppColors.c5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "example@gmail.com",
                      style: Styles.textStyle12.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const OtpInput(),
                    const SizedBox(height: 38),
                    CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.preference);
                      },
                      text: 'Verify',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
