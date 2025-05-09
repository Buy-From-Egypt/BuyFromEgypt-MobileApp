import 'dart:math';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/CustomTextButton.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buy_from_egypt/services/notification_service.dart';



class SignUpForm extends StatefulWidget {
  final Function(String email, String phoneNumber) onShowOtp;

  const SignUpForm({super.key, required this.onShowOtp});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _taxIdController;
  late final TextEditingController _nationalIdController;
  late final TextEditingController _countryController;
  late final TextEditingController _passwordController;

  String selectedType = 'Importer';
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _taxIdController = TextEditingController();
    _nationalIdController = TextEditingController();
    _countryController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _taxIdController.dispose();
    _nationalIdController.dispose();
    _countryController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validator function
  String? _fieldValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
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

  // Password validator
  String? _passwordValidator(dynamic value) {
    final stringValue = value?.toString();
    if (stringValue == null || stringValue.isEmpty) {
      return 'Please enter a password';
    }
    if (stringValue.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _validateAndSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final supabase = Supabase.instance.client;
        final email = _emailController.text.trim();
        final phone = _phoneController.text.trim();

        // Generate OTP as string to match database TEXT type
        final random = Random.secure();
        final String otp = (1000 + random.nextInt(9000)).toString();
        print('Debug - Generated OTP (string): $otp');

        // Show notification with OTP
        await NotificationService.showOtpNotification(otp);

        // First insert into customers table to get the ID
        final customerData = await supabase.from('customers').insert({
          'email': email,
          'password':
              sha256.convert(utf8.encode(_passwordController.text)).toString(),
          'name': _nameController.text.trim(),
          'phone_number': phone,
          'tax_id': _taxIdController.text.trim(),
          'national_id': _nationalIdController.text.trim(),
          'country': _countryController.text.trim(),
          'type':
              selectedType, // This will be exactly 'Importer', 'Exporter', or 'Both'
        }).select();

        final customerId = customerData[0]['id'];

        // Delete any existing OTPs for this user first
        await supabase.from('otps').delete().eq('user_id', customerId);

        // Store new OTP in database
        await supabase.from('otps').insert({
          'user_id': customerId,
          'otp': otp,
          'expires_at':
              DateTime.now().add(const Duration(minutes: 5)).toIso8601String(),
        });

        print('Debug - OTP stored in database: $otp for user: $customerId');

        // Store in preferences as string
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('otp', otp);
        await prefs.setString('notification_otp', otp);
        await prefs.setString('email', email);
        await prefs.setString('otp_expiration',
            DateTime.now().add(const Duration(minutes: 5)).toIso8601String());

        widget.onShowOtp(email, phone);
      } catch (e) {
        print('Debug - Storage Error Details: ${e.toString()}');
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
    return Container(
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Full Name',
                icon: SolarIconsOutline.user,
                hintText: 'Your Name',
                controller: _nameController,
                onChanged: (value) => setState(() {}),
                validator: (value) => _fieldValidator(value, 'full name'),
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Email Address',
                imagePath: 'assets/images/Message.svg',
                hintText: 'example@gmail.com',
                controller: _emailController,
                onChanged: (value) => setState(() {}),
                validator: _emailValidator,
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Phone Number',
                hintText: '(+20) 155 000 0000',
                isNumber: true,
                controller: _phoneController,
                onChanged: (value) => setState(() {}),
                validator: (value) => _fieldValidator(value, 'phone number'),
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Tax ID',
                hintText: '123-456-789',
                imagePath: 'assets/images/id-card-h.svg',
                isNumber: true,
                controller: _taxIdController,
                onChanged: (value) => setState(() {}),
                validator: (value) => _fieldValidator(value, 'tax ID'),
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'National ID',
                hintText: '30303562804756',
                imagePath: 'assets/images/id-card-h.svg',
                isNumber: true,
                controller: _nationalIdController,
                onChanged: (value) => setState(() {}),
                validator: (value) => _fieldValidator(value, 'national ID'),
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Your Country',
                hintText: 'Egypt',
                imagePath: 'assets/images/Global.svg',
                controller: _countryController,
                onChanged: (value) => setState(() {}),
                validator: (value) => _fieldValidator(value, 'country'),
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Password',
                icon: SolarIconsOutline.lock,
                hintText: '********',
                isPassword: true,
                controller: _passwordController,
                onChanged: (value) => setState(() {}),
                validator: _passwordValidator,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'You are',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                value: selectedType,
                items: const [
                  DropdownMenuItem(
                    value: 'Exporter',
                    child: Text('Exporter'),
                  ),
                  DropdownMenuItem(
                    value: 'Importer',
                    child: Text('Importer'),
                  ),
                  DropdownMenuItem(
                    value: 'Both',
                    child: Text('Both'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: _isLoading ? () {} : _validateAndSignUp,
                text: 'Sign Up',
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              CustomTextButton(
                text1: 'Already have an account? ',
                text2: 'Login Here',
                onPressed: () {
                  
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
