import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/header.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/otp_form.dart';
import 'package:flutter/material.dart';

class OtpForgetPassword extends StatelessWidget {
  const OtpForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Rectangle.png',
              fit: BoxFit.cover,
            ),
          ),
           Column(
            children: [
              const Header(
                  title: 'OTP Verification',
                  description:
                      'Enter 4 digits verification code we have send to your email'),
              Expanded(
                child:Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const OtpForm(),
                ),
                 ),
            ],
          )
        ],
      ),
    );
  }
}