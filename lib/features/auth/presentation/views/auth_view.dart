import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/error_utils.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/otp_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_tab_bar.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/header.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/login_header.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/signup_form.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'dart:async';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _logger = Logger();
  bool _isSignUpSelected = true;
  bool _isLoading = false;
  bool _hasInternetConnection = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      setState(() {
        _hasInternetConnection = !results.contains(ConnectivityResult.none);
      });
      if (!_hasInternetConnection) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No internet connection. Please check your network and try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Future<void> _checkConnectivity() async {
    try {
      final results = await Connectivity().checkConnectivity();
      setState(() {
        _hasInternetConnection = !results.contains(ConnectivityResult.none);
      });
      if (!_hasInternetConnection) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No internet connection. Please check your network and try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      _logger.e('Error checking connectivity: $e', error: e);
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _showOtpDialog(String email, String phone, String userType) {
    if (!_hasInternetConnection) {
      ErrorUtils.showErrorSnackBar(
        context,
        'No internet connection. Please check your network and try again.',
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: OtpView(
          email: email,
          phoneNumber: phone,
          userType: userType,
        ),
      ),
    );
  }

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
          if (!_hasInternetConnection)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Center(
                  child: Text(
                    'No Internet Connection',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          Column(
            children: [
              _isSignUpSelected
                  ? const Header(
                      title: "Create Account",
                      description: 'Ready to Expand Your Business?',
                    )
                  : const LoginHeader(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomTabBar(
                          isSignUpSelected: _isSignUpSelected,
                          onTabChange: (isSignUp) {
                            setState(() => _isSignUpSelected = isSignUp);
                          },
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: _isSignUpSelected
                              ? SignUpForm(
                                  onShowOtp: _showOtpDialog,
                                )
                              : LoginForm(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
