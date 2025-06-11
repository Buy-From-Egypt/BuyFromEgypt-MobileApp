import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/auth_utils.dart';
import 'package:buy_from_egypt/core/utils/error_utils.dart';
import 'package:buy_from_egypt/core/utils/secure_storage.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/CustomTextButton.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/LabeledTextField.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/remember.dart';
import 'package:buy_from_egypt/features/home/presentation/views/home_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/pending_view.dart';
import 'package:buy_from_egypt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  int _failedAttempts = 0;
  DateTime? _lastFailedAttempt;
  static const int _maxFailedAttempts = 5;
  static const Duration _lockoutDuration = Duration(minutes: 15);
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rememberMe = prefs.getBool('remember_me') ?? false;
      
      if (rememberMe) {
        final credentials = await SecureStorage.getUserCredentials();
        if (credentials['email'] != null && credentials['password'] != null) {
          setState(() {
            _emailController.text = credentials['email']!;
            _passwordController.text = credentials['password']!;
            _rememberMe = true;
          });
        }
      }
    } catch (e) {
      logger.e('Error loading saved credentials: $e');
    }
  }

  bool _isAccountLocked() {
    if (_lastFailedAttempt == null) return false;
    return _failedAttempts >= _maxFailedAttempts &&
        DateTime.now().difference(_lastFailedAttempt!) < _lockoutDuration;
  }

  String? _getLockoutMessage() {
    if (!_isAccountLocked()) return null;
    final remainingTime = _lockoutDuration -
        DateTime.now().difference(_lastFailedAttempt!);
    return 'Account locked. Please try again in ${remainingTime.inMinutes} minutes';
  }

  Future<void> _signIn() async {
    if (_isAccountLocked()) {
      ErrorUtils.showErrorSnackBar(context, _getLockoutMessage()!);
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection. Please check your network and try again.');
      }

      // Sign in with API
      final response = await ApiService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      // Save session data
      await AuthUtils.saveUserSession(response);

      // Save credentials if "Remember Me" is checked
      if (_rememberMe) {
        await SecureStorage.saveUserCredentials(
          _emailController.text.trim(),
          _passwordController.text,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('remember_me', true);
      } else {
        await SecureStorage.deleteUserCredentials();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('remember_me', false);
      }

      if (mounted) {
        // Show success message
        ErrorUtils.showSuccessSnackBar(context, 'Login successful!');

        // Clear all previous routes and navigate to home
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeView(),
            settings: const RouteSettings(name: '/home'),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      _failedAttempts++;
      _lastFailedAttempt = DateTime.now();

      if (mounted) {
        String errorMessage;
        if (e.toString().contains('INACTIVE_ACCOUNT')) {
          // Navigate to pending view for inactive accounts
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => PendingView(email: _emailController.text.trim()),
              settings: const RouteSettings(name: '/pending'),
            ),
            (route) => false,
          );
          return;
        } else if (e.toString().contains('Invalid response from server')) {
          errorMessage = 'Unable to connect to the server. Please try again later.';
        } else if (e.toString().contains('No internet connection')) {
          errorMessage = 'Please check your internet connection and try again.';
        } else {
          errorMessage = e.toString().replaceAll('Exception: ', '');
        }

        ErrorUtils.showErrorSnackBar(
          context,
          _isAccountLocked() ? _getLockoutMessage()! : errorMessage,
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
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                      label: 'Password',
                      icon: SolarIconsOutline.lock,
                      hintText: '********',
                      isPassword: true,
                      controller: _passwordController,
                      onChanged: (_) => setState(() {}),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
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
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Remember(
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value;
                                });
                              },
                              initialValue: _rememberMe,
                            ),
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
                        DefaultTabController.of(context).animateTo(1);
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
