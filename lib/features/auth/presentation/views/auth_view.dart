import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/otp_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_tab_bar.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/header.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/login_header.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/signup_form.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _showVerifyOverlay = false;
  bool _isSignUpSelected = true;

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
              _isSignUpSelected
                  ? const Header(
                      title: "Create Account",
                      description: ' Ready to Expand Your Business?',
                    )
                  : const LoginHeader(),
              Expanded(
                child: Container(
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTabBar(
                          isSignUpSelected: _isSignUpSelected,
                          onTabChange: (isSignUp) {
                            setState(() => _isSignUpSelected = isSignUp);
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: _isSignUpSelected
                              ? SignUpForm(
                                  onShowOtp: () {
                                    setState(() => _showVerifyOverlay = true);
                                  },
                                )
                              : const LoginForm(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showVerifyOverlay)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: OtpView(
                    onClose: () {
                      setState(() => _showVerifyOverlay = false);
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
