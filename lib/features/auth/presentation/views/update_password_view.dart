import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/successfully_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';


class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  String? _passwordValidator(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return 'Please enter a password';
    }
    if (value.toString().length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _confirmPasswordValidator(dynamic value) {
    if (value.toString() != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('reset_user_id');

      if (userId == null) throw Exception('User ID not found');

      final supabase = Supabase.instance.client;
      final hashedPassword = _hashPassword(_passwordController.text);

      // Update the password in the customers table
      await supabase.from('customers').update({
        'password': hashedPassword,
      }).eq('id', userId);

      if (mounted) {
        // Clear stored data
        await prefs.remove('reset_user_id');
        await prefs.remove('email');

        // Navigate to success screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SuccessfullyView(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating password: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                title: 'Reset Password',
                description: 'Enter your new password',
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
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          LabeledTextField(
                            label: 'New Password',
                            hintText: '********',
                            isPassword: true,
                            controller: _passwordController,
                            validator: _passwordValidator,
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 16),
                          LabeledTextField(
                            label: 'Confirm Password',
                            hintText: '********',
                            isPassword: true,
                            controller: _confirmPasswordController,
                            validator: _confirmPasswordValidator,
                            onChanged: (_) {}, 
                          ),
                          const SizedBox(height: 32),
                          CustomButton(
                            text: 'Update Password',
                            onPressed: _isLoading ? null : _updatePassword,
                            isLoading: _isLoading,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
