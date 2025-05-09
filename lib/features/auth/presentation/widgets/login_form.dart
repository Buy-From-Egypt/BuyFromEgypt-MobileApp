import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/auth_utils.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/preference_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/CustomTextButton.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/remember.dart';
import 'package:buy_from_egypt/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty)
      return;

    setState(() => _isLoading = true);
    try {
      final supabase = Supabase.instance.client;

      // Sign in with Supabase
      final authResponse = await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (authResponse.user == null) throw Exception('Login failed');

      // Get customer data
      final userData = await supabase
          .from('customers')
          .select()
          .eq('email', _emailController.text.trim())
          .single();

      // Save session data
      await AuthUtils.saveUserSession(userData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate based on user type
        if (userData['type'] == 'Importer') {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const PreferenceView()),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          constraints: BoxConstraints(
            minHeight: constraints.minHeight,
            maxHeight: constraints.maxHeight,
          ),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'Email Address',
                      imagePath: 'assets/images/Message.svg',
                      hintText: 'example@gmail.com',
                      controller: _emailController,
                      onChanged: (_) => setState(() {}),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your email'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'Password',
                      icon: SolarIconsOutline.lock,
                      hintText: '********',
                      isPassword: true,
                      controller: _passwordController,
                      onChanged: (_) => setState(() {}),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your password'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Remember(),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.forgetPassword);
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomButton(
                      onPressed: _isLoading ? null : _signIn,
                      text: 'Sign In',
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 16),
                    CustomTextButton(
                      text1: "You're new in here? ",
                      text2: "Create Account",
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
