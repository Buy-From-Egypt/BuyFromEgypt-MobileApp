import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/otp_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_tab_bar.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_icons/solar_icons.dart';

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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Rectangle.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.c5,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: FaIcon(
                              SolarIconsOutline.arrowLeft,
                              size: 18,
                              color: AppColors.background,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create Account",
                              style: Styles.textStyle22
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Ready to Expand Your Business?",
                              style: Styles.textStyle14
                                  .copyWith(color: AppColors.c7),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 327,
                            child: CustomTabBar(),
                          ),
                          const SizedBox(height: 32),
                          const CustomTextField(
                              label: "Full Name", icon: SolarIconsOutline.user),
                          const SizedBox(height: 16),
                          const CustomTextField(
                              label: "Email Address",
                              icon: FontAwesomeIcons.envelope),
                          const SizedBox(height: 16),
                          const CustomTextField(
                            label: "Password",
                            icon: SolarIconsOutline.lock,
                            isPassword: true,
                          ),
                          const SizedBox(height: 41),
                          SizedBox(
                            width: 327, // Fixed width
                            height: 48, // Fixed height
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showVerifyOverlay = true;
                                });
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {}, // Add navigation logic
                            child: const Text(
                              "Already have an account? Login Here",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
