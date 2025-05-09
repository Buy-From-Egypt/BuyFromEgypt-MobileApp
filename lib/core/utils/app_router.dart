import 'package:buy_from_egypt/features/auth/presentation/views/auth_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/forget_password_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/otp_forget_password.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/pending_more_info.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/pending_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/preference_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/successfully_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/update_password_view.dart';
import 'package:buy_from_egypt/features/home/presentation/views/home_view.dart';
import 'package:buy_from_egypt/features/home/presentation/views/search_view.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/views/onboarding_screens.dart';
import 'package:buy_from_egypt/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const AuthView());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case AppRoutes.updatePassword:
        return MaterialPageRoute(builder: (_) => const UpdatePasswordView());
        case AppRoutes.otpForgetPassword:
        return MaterialPageRoute(builder: (_) => const OtpForgetPasswordScreen());
      case AppRoutes.successfully:
        return MaterialPageRoute(builder: (_) => const SuccessfullyView());
      case AppRoutes.preference:
        return MaterialPageRoute(builder: (_) => const PreferenceView());
        case AppRoutes.pending:
        return MaterialPageRoute(builder: (_) => const PendingView());
        case AppRoutes.pendingMoreInfo:
        return MaterialPageRoute(builder: (_) => const PendingMoreInfo());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchView());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
