import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class PendingMoreInfo extends StatelessWidget {
  const PendingMoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 24),
          icon: Image.asset(
            'assets/images/back frame.png',
            height: 36,
            width: 36,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Account Revision',
          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: UserInfo(),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ProfileImage(
                path: 'assets/images/samsun.png',
                width: 48,
                height: 48,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Samsung Electronics ',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Computers and Electronics Manufacturing',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'What’s Next',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w500,
              height: 1.46,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Color(0xFFA7A99C),
                fontSize: 14,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                height: 1.43,
              ),
              children: [
                TextSpan(
                  text:
                      '• Document verification usually takes between 24–48 hours.\n',
                ),
                TextSpan(
                  text:
                      '• You\'ll receive a confirmation email once your account is approved.\n',
                ),
                TextSpan(
                  text:
                      '• You will then be able to explore, connect, and trade freely.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/unsplash_XE8Pe5uz_WI.jpg',
              width: double.infinity,
              height: 218,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
