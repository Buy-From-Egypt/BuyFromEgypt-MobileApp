import 'package:buy_from_egypt/features/auth/presentation/views/sign_up_view.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/views/onboarding_screens.dart';
import 'package:buy_from_egypt/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
