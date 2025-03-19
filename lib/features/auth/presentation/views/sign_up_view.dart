import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/otp_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/signup_header.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _showVerifyOverlay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
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
              const SignUpHeader(), 
              Expanded(child: SignUpForm(
                onSignUpPressed: () {
                  setState(() {
                    _showVerifyOverlay = true;
                  });
                },
              )),
            ],
          ),

          if (_showVerifyOverlay)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(child: OtpView()),
              ),
            ),
        ],
      ),
    );
  }
}
