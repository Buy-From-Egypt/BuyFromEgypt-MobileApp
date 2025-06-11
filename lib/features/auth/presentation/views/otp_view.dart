import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/error_utils.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/otp_form.dart';
import 'package:buy_from_egypt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class OtpView extends StatefulWidget {
  final String email;
  final String phoneNumber;
  final String userType;

  const OtpView({
    super.key,
    required this.email,
    required this.phoneNumber,
    required this.userType,
  });

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  bool _isLoading = false;
  String _errorMessage = '';
  String _currentOtp = '';

  Future<void> _verifyOtp(String otp) async {
    if (otp.length != 6) return;

    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        if (!mounted) return;
        setState(() => _errorMessage =
            'No internet connection. Please check your network and try again.');
        return;
      }

      // Verify OTP using API
      await ApiService.verifyOtp(widget.email, otp);

      if (!mounted) return;

      // Navigate to pending view after successful verification
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.pending,
        (route) => false,
        arguments: {'email': widget.email},
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Verify Your Email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Please enter the 6-digit code sent to ${widget.email}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            OtpForm(
              onOtpChanged: (otp) {
                setState(() => _currentOtp = otp);
              },
              onCompleted: _verifyOtp,
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
