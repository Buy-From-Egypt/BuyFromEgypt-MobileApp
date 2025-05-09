import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/update_password_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/header.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpForgetPassword {
  Future<void> verifyOtp(String email, String otp, BuildContext context) async {
    try {
      final supabase = Supabase.instance.client;

      final customerData = await supabase
          .from('customers')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (customerData == null) {
        throw Exception('User not found');
      }

      final customerId = customerData['id'];
      final otpData = await supabase
          .from('otps')
          .select()
          .eq('user_id', customerId)
          .eq('reset_password_otp', int.parse(otp))
          .maybeSingle();

      if (otpData == null) {
        throw Exception('Invalid OTP');
      }

      // Check if OTP is expired
      final expiresAt = DateTime.parse(otpData['expires_at']);
      if (DateTime.now().isAfter(expiresAt)) {
        throw Exception('OTP has expired');
      }

      // OTP is valid, delete it
      await supabase.from('otps').delete().eq('user_id', customerId);

      // Store user ID for password reset
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('reset_user_id', customerId.toString());

      // Navigate to update password screen
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdatePasswordView(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
      print('Debug - Verification error details: $e');
      rethrow;
    }
  }
}

class OtpForgetPasswordScreen extends StatelessWidget {
  const OtpForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
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
                    title: 'OTP Verification',
                    description:
                        'Enter 4 digits verification code shown in the notification',
                  ),
                  Expanded(
                    child: Container(
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: const SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: OtpForm(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
