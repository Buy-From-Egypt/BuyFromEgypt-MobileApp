import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/forget_password_form.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/header.dart';
import 'package:buy_from_egypt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  int _requestAttempts = 0;
  DateTime? _lastRequestAttempt;
  static const int _maxRequestAttempts = 3;
  static const Duration _cooldownDuration = Duration(minutes: 5);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isRequestLocked() {
    if (_lastRequestAttempt == null) return false;
    return _requestAttempts >= _maxRequestAttempts &&
        DateTime.now().difference(_lastRequestAttempt!) < _cooldownDuration;
  }

  String? _getLockoutMessage() {
    if (!_isRequestLocked()) return null;
    final remainingTime = _cooldownDuration -
        DateTime.now().difference(_lastRequestAttempt!);
    return 'Too many attempts. Please try again in ${remainingTime.inMinutes} minutes';
  }

  Future<void> _requestPasswordReset(String email) async {
    if (_isRequestLocked()) {
      setState(() => _errorMessage = _getLockoutMessage()!);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection. Please check your network and try again.');
      }

      // Request OTP using API
      await ApiService.requestOtp(email);

      if (!mounted) return;

      // Navigate to OTP verification screen
      await Navigator.pushNamed(
        context,
        AppRoutes.otpForgetPassword,
        arguments: {'email': email},
      );
    } catch (e) {
      _requestAttempts++;
      _lastRequestAttempt = DateTime.now();
      if (!mounted) return;
      setState(() => _errorMessage = e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          const Header(
            title: 'Forget Password',
            description:
                "No stress! Just tell us where to send your reset link, and you'll be back in no time.",
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ForgetPasswordForm(
                    onShowOtp: _requestPasswordReset,
                    isLoading: _isLoading,
                    errorMessage: _errorMessage,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
  
