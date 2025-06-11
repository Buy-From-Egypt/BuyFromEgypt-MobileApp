import 'dart:math';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/error_utils.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/CustomTextButton.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/you_are_dropdown.dart';
import 'package:buy_from_egypt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buy_from_egypt/services/notification_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

final logger = Logger();

class SignUpForm extends StatefulWidget {
  final Function(String email, String phoneNumber, String userType) onShowOtp;

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
  late final TextEditingController _ageController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  String selectedType = 'Importer';
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _taxIdController = TextEditingController();
    _nationalIdController = TextEditingController();
    _countryController = TextEditingController();
    _ageController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _taxIdController.dispose();
    _nationalIdController.dispose();
    _countryController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _validateAndSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection. Please check your network and try again.');
      }

      // Clean and validate data
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final phone = _phoneController.text.trim();
      final taxId = _taxIdController.text.trim();
      final nationalId = _nationalIdController.text.trim();
      final country = _countryController.text.trim();
      final age = int.tryParse(_ageController.text.trim()) ?? 0;
      final password = _passwordController.text;

      // Additional validation
      if (name.length < 3) {
        throw Exception('Name must be at least 3 characters long');
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        throw Exception('Please enter a valid email address');
      }

      if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(phone)) {
        throw Exception('Please enter a valid phone number');
      }

      if (!RegExp(r'^\d{9}$').hasMatch(taxId)) {
        throw Exception('Tax ID must be exactly 9 digits');
      }

      if (!RegExp(r'^\d{14}$').hasMatch(nationalId)) {
        throw Exception('National ID must be exactly 14 digits');
      }

      if (country.length < 2) {
        throw Exception('Please enter a valid country name');
      }

      if (age < 18 || age > 100) {
        throw Exception('Age must be between 18 and 100');
      }

      if (password.length < 8) {
        throw Exception('Password must be at least 8 characters long');
      }

      // Format phone number to remove spaces and special characters
      final formattedPhone = phone.replaceAll(RegExp(r'[\s-]'), '');

      // Register user with API
      final userData = {
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': formattedPhone,
        'type': selectedType,
        'taxId': taxId,
        'registrationNumber': '',
        'industrySector': '',
        'commercial': '',
        'nationalId': nationalId,
        'country': country,
        'age': age,
        'address': '',
      };

      logger.i('Sending registration data: ${jsonEncode(userData)}');
      await ApiService.register(userData);

      // Request OTP after successful registration
      logger.i('Requesting OTP for email: $email');
      await ApiService.requestOtp(email);

      if (mounted) {
        // Show OTP dialog with user type
        widget.onShowOtp(email, formattedPhone, selectedType);
      }

    } catch (e) {
      if (mounted) {
        String errorMessage;
        if (e.toString().contains('Internal server error')) {
          errorMessage = 'The server is currently experiencing issues. Please try again in a few minutes.';
        } else if (e.toString().contains('Invalid response from server')) {
          errorMessage = 'Unable to connect to the server. Please try again later.';
        } else if (e.toString().contains('No internet connection')) {
          errorMessage = 'Please check your internet connection and try again.';
        } else if (e.toString().contains('email already exists')) {
          errorMessage = 'This email is already registered. Please use a different email or try logging in.';
        } else if (e.toString().contains('phone number already exists')) {
          errorMessage = 'This phone number is already registered. Please use a different phone number.';
        } else if (e.toString().contains('SocketException')) {
          errorMessage = 'Unable to connect to the server. Please check your internet connection.';
        } else {
          errorMessage = e.toString().replaceAll('Exception: ', '');
        }

        ErrorUtils.showErrorSnackBar(context, errorMessage);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Email Address',
                imagePath: 'assets/images/Message.svg',
                hintText: 'example@gmail.com',
                controller: _emailController,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Phone Number',
                hintText: '(+20) 155 000 0000',
                isNumber: true,
                controller: _phoneController,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }
                  final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Tax ID',
                hintText: '123-456-789',
                imagePath: 'assets/images/id-card-h.svg',
                isNumber: true,
                controller: _taxIdController,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your tax ID';
                  }
                  final taxIdRegex = RegExp(r'^\d{9}$');
                  if (!taxIdRegex.hasMatch(value)) {
                    return 'Tax ID must be 9 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'National ID',
                hintText: '30303562804756',
                imagePath: 'assets/images/id-card-h.svg',
                isNumber: true,
                controller: _nationalIdController,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your national ID';
                  }
                  final nationalIdRegex = RegExp(r'^\d{14}$');
                  if (!nationalIdRegex.hasMatch(value)) {
                    return 'National ID must be 14 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Your Country',
                hintText: 'Egypt',
                imagePath: 'assets/images/Global.svg',
                controller: _countryController,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your country';
                  }
                  if (value.length < 2) {
                    return 'Please enter a valid country name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Age',
                hintText: '22',
                imagePath: 'assets/images/id-card-h.svg',
                isNumber: true,
                controller: _ageController,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your age';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age < 18 || age > 100) {
                    return 'Age must be between 18 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Password',
                icon: SolarIconsOutline.lock,
                hintText: '********',
                isPassword: true,
                controller: _passwordController,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? SolarIconsOutline.eye
                        : SolarIconsOutline.eyeClosed,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Confirm Password',
                icon: SolarIconsOutline.lock,
                hintText: '********',
                isPassword: true,
                controller: _confirmPasswordController,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? SolarIconsOutline.eye
                        : SolarIconsOutline.eyeClosed,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              YouAre(
                onUserTypeSelected: (String userType) {
                  setState(() {
                    selectedType = userType;
                  });
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: _isLoading ? null : _validateAndSignUp,
                text: 'Create Account',
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              CustomTextButton(
                text1: 'Already have an account? ',
                text2: 'Login Here',
                onPressed: () {
                  Navigator.pop(context);
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
