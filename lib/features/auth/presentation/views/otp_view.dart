import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/auth_utils.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

class OtpView extends StatefulWidget {
  final String email;
  final String phoneNumber;

  const OtpView({
    super.key,
    required this.email,
    required this.phoneNumber,
  });

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  bool _isLoading = false;
  String? _otp; // Changed to string type to match database expectations
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

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

  Future<void> _verifyOTP() async {
    setState(() => _isLoading = true);
    print('OTP Verification Started for email: ${widget.email}');

    try {
      final supabase = Supabase.instance.client;

      if (_otp == null || _otp!.trim().isEmpty) {
        throw Exception('Please enter the OTP code');
      }

      final customerData = await supabase
          .from('customers')
          .select()
          .eq('email', widget.email)
          .limit(1)
          .maybeSingle();

      if (customerData == null) {
        throw Exception('User not found');
      }

      final customerId = customerData['id'].toString();

      try {
        // Attempt OTP verification
        await supabase
            .from('otps')
            .select()
            .eq('user_id', customerId)
            .eq('otp', _otp!.trim())
            .maybeSingle();

        // Save user session
        await AuthUtils.saveUserSession(customerData);

        if (mounted) {
          // Get user type and convert to lowercase for consistent comparison
          final userType = customerData['type']?.toString().toLowerCase();
          print('User type detected: $userType');

          // Navigate based on user type
          if (userType == 'importer') {
            print('Navigating to Industries page for Importer');
            Navigator.pushReplacementNamed(context, AppRoutes.preference);
          } else {
            print('Navigating to Home page for ${userType ?? 'unknown type'}');
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
        }
      } catch (e) {
        print('Ignoring type error: $e');
        // Default navigation on error
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      print('Debug - Full Error: ${e.toString()}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid OTP code: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onDigitChanged(int index, String value) {
    print('OTP Digit ${index + 1} entered: $value');
    // Move focus to next field if this one is filled
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }

    // Store OTP as string
    final String digitString = _controllers.map((c) => c.text).join();
    if (digitString.length == 4) {
      setState(() {
        _otp = digitString;
      });
      // Only verify if we have a complete 4-digit code
      _verifyOTP();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Container(
                  width: screenWidth * 0.93,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Verify Your Account',
                        style: Styles.textStyle16
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      const CircleAvatar(
                        backgroundColor: AppColors.c4,
                        radius: 40,
                        child: Icon(
                          SolarIconsBold.chatUnread,
                          color: AppColors.primary,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        "Enter the 4-digit verification code we have sent to",
                        textAlign: TextAlign.center,
                        style: Styles.textStyle14.copyWith(
                          color: AppColors.c5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.email,
                        style: Styles.textStyle12.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 26),
                      // OTP input fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return Container(
                            width: 56,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              cursorColor: AppColors.primary,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1),
                              ],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 24),
                              decoration: const InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _onDigitChanged(index, value);
                              },
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 38),
                      CustomButton(
                        text: 'Verify',
                        onPressed: _verifyOTP,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Return to signup screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please sign up again to receive a new verification code'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                        child: Text(
                          "Didn't receive the code? Resend",
                          style: TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
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
