import 'package:flutter/foundation.dart';

class Env {
  static String get dbUrl => const String.fromEnvironment('DB_URL',
      defaultValue: 'https://idjaqtqdqzcupqwkgvuu.supabase.co');

  static String get dbApiKey => const String.fromEnvironment('DB_API_KEY',
      defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlkamFxdHFkcXpjdXBxd2tndnV1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1MTYxMjEsImV4cCI6MjA2MjA5MjEyMX0.zhpUtgw100MJcWslWSC6KNTz3k14l7KTFa9oWyK9YtE');

  // Add more environment variables as needed
  
  static void logEnvInfo() {
    if (kDebugMode) {
      print('Environment Variables:');
      print('DB_URL: $dbUrl');
      // Only log non-sensitive info in debug mode
    }
  }
}