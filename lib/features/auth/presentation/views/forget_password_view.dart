import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/forget_password_form.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/header.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

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
                  title: 'Forget Password',
                  description:
                      'No stress! Just tell us where to send your reset link, and you’ll be back in no time.'),
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
                  child: const ForgetPasswordForm(),
                ),
                 ),
            ],
          )
        ],
      ),
    );
  }
}
