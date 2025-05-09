import 'package:buy_from_egypt/core/utils/app_router.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/auth_utils.dart';
import 'package:buy_from_egypt/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications first
  await NotificationService.initialize();

  await Supabase.initialize(
    url: 'https://idjaqtqdqzcupqwkgvuu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlkamFxdHFkcXpjdXBxd2tndnV1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1MTYxMjEsImV4cCI6MjA2MjA5MjEyMX0.zhpUtgw100MJcWslWSC6KNTz3k14l7KTFa9oWyK9YtE',
  );

  // Request notification permissions explicitly
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> _getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    if (!hasSeenOnboarding) {
      return AppRoutes.onboarding;
    }

    final isLoggedIn = await AuthUtils.checkSession();
    if (!isLoggedIn) {
      return AppRoutes.auth;
    }

    final userType = prefs.getString('user_type');
    if (userType == 'Importer') {
      return AppRoutes.preference;
    } else {
      return AppRoutes.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: snapshot.data!,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}