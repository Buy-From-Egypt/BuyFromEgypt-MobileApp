import 'dart:async';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/services/api_service.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:flutter_svg/svg.dart';

class PendingView extends StatefulWidget {
  final String email;

  const PendingView({super.key, required this.email});

  @override
  State<PendingView> createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  late Timer _timer;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _checkAccountStatus());
  }

  Future<void> _checkAccountStatus() async {
    try {
      final response = await ApiService.login(widget.email, 'dummy-password');
      if (response['status'] == 'ACTIVE') {
        _isActive = true;
        _timer.cancel();
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
        }
      }
    } catch (e) {
      // Handle errors silently (optional: show Snackbar or log)
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SvgPicture.asset(
              'assets/images/undraw_file-search_cbur 1.svg',
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your account is under review',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please wait for admin approval.\nWe’ll notify you by email once approved.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          CustomButton(onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.auth,
                      (route) => false,
                    );
          }, text: 'Back to Login', isLoading: false),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
