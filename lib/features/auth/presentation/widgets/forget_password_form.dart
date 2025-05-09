import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/CustomTextButton.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';
import 'package:buy_from_egypt/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Email validator with regex
  String? _emailValidator(dynamic value) {
    final stringValue = value?.toString();
    if (stringValue == null || stringValue.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(stringValue)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  Future<void> _handleForgetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final supabase = Supabase.instance.client;
        final email = _emailController.text.trim();

        // Check if user exists
        final userResponse = await supabase
            .from('customers')
            .select('id, password')
            .eq('email', email)
            .maybeSingle();

        if (userResponse == null) {
          throw Exception('No account found with this email address');
        }

        final userId = userResponse['id'];

        // Generate exactly 4-digit OTP
        final otp = (1000 + Random().nextInt(9000)).toString().padLeft(4, '0');

        // Show OTP notification
        await NotificationService.showOtpNotification(otp);

        // Store OTP in database with current timestamp
        final expirationTime = DateTime.now().add(const Duration(minutes: 5));

        // Delete any existing OTPs for this user
        await supabase.from('otps').delete().eq('user_id', userId);

        // Insert new OTP
        await supabase.from('otps').insert({
          'user_id': userId,
          'otp': otp,
          'expires_at': expirationTime.toIso8601String(),
          'reset_password_otp': int.parse(otp),
        });

        // Save email to shared preferences for verification
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);

        if (mounted) {
          Navigator.pushNamed(
            context,
            AppRoutes.otpForgetPassword,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LabeledTextField(
                    label: 'Email Address',
                    imagePath: 'assets/images/Message.svg',
                    hintText: 'example@gmail.com',
                    controller: _emailController,
                    validator: _emailValidator,
                  ),
                  const SizedBox(height: 28),
                  CustomButton(
                    onPressed: _isLoading ? () {} : _handleForgetPassword,
                    text: 'Send OTP',
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 16),
                  CustomTextButton(
                    text1: 'Remembered it? ',
                    text2: 'Back to Login',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
