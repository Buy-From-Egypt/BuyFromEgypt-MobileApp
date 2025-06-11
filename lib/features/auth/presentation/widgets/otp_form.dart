import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/error_utils.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/otp_forget_password.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/update_password_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class OtpForm extends StatefulWidget {
  final Function(String) onOtpChanged;
  final Function(String)? onCompleted;

  const OtpForm({
    super.key,
    required this.onOtpChanged,
    this.onCompleted,
  });

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  bool _isVerifying = false;
  int _verificationAttempts = 0;
  DateTime? _lastVerificationAttempt;
  static const int _maxVerificationAttempts = 3;
  static const Duration _cooldownDuration = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
  }

  bool _isVerificationLocked() {
    if (_lastVerificationAttempt == null) return false;
    return _verificationAttempts >= _maxVerificationAttempts &&
        DateTime.now().difference(_lastVerificationAttempt!) < _cooldownDuration;
  }

  String? _getLockoutMessage() {
    if (!_isVerificationLocked()) return null;
    final remainingTime = _cooldownDuration -
        DateTime.now().difference(_lastVerificationAttempt!);
    return 'Too many verification attempts. Please try again in ${remainingTime.inMinutes} minutes';
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _updateOtp() {
    final String otpString = _controllers.map((c) => c.text).join();
    widget.onOtpChanged(otpString);
    if (otpString.length == 6 && widget.onCompleted != null) {
      widget.onCompleted!(otpString);
    }
  }

  void _onDigitEntered(int index, String value) {
    if (value.length == 1) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
      _updateOtp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 40,
              child: TextFormField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                onChanged: (value) => _onDigitEntered(index, value),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        CustomButton(
          onPressed: _isVerifying ? null : () {
            final otp = _controllers.map((c) => c.text).join();
            if (otp.length == 6 && widget.onCompleted != null) {
              widget.onCompleted!(otp);
            }
          },
          text: 'Verify',
          isLoading: _isVerifying,
        ),
      ],
    );
  }
}
