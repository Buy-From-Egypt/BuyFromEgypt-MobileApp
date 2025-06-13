import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/auth_utils.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/auth_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/forget_password_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/otp_forget_password.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/pending_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/preference_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/successfully_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/update_password_view.dart';
import 'package:buy_from_egypt/features/home/presentation/views/home_view.dart';
import 'package:buy_from_egypt/features/home/presentation/views/search_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/market_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/order1_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/order2_view.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/views/onboarding_screens.dart';
import 'package:buy_from_egypt/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Initialize app
  await initializeApp();

  runApp(const MyApp());
}

Future<void> initializeApp() async {
  try {
    // Check connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      logger.w('No internet connection during initialization');
    }

    // Clear any existing session
    await AuthUtils.clearUserSession();

    logger.i('App initialized successfully');
  } catch (e) {
    logger.e('Error initializing app: $e', error: e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buy From Egypt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary),
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashView(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.auth: (context) => const AuthView(),
        AppRoutes.home: (context) => const HomeView(),
        AppRoutes.market: (context) => MarketView(),
        AppRoutes.orders1: (context) => const Order1View(),
        AppRoutes.orders2: (context) => const Orders2View(),
        AppRoutes.forgetPassword: (context) => const ForgetPasswordView(),
        AppRoutes.updatePassword: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final email = args?['email'] as String?;
          if (email == null) {
            return const Scaffold(
              body: Center(child: Text('Email is required for password update')),
            );
          }
          return UpdatePasswordView(email: email);
        },
        AppRoutes.otpForgetPassword: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final email = args?['email'] as String?;
          if (email == null) {
            return const Scaffold(
              body: Center(child: Text('Email is required for OTP verification')),
            );
          }
          return OtpForgetPassword(email: email);
        },
        AppRoutes.successfully: (context) => const SuccessfullyView(),
        AppRoutes.preference: (context) => const PreferenceView(),
        AppRoutes.pending: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final email = args?['email'] as String?;
          if (email == null) {
            return const Scaffold(
              body: Center(child: Text('Email is required')),
            );
          }
          return PendingView(email: email);
        },
        AppRoutes.search: (context) => const SearchView(),
      },
    );
  }
}