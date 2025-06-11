import 'dart:async';
import 'package:flutter/material.dart';

class ErrorUtils {
  static Future<T> withRetry<T>(
    Future<T> Function() operation, {
    int maxAttempts = 3,
    Duration delay = const Duration(seconds: 2),
  }) async {
    int attempts = 0;
    while (attempts < maxAttempts) {
      try {
        return await operation();
      } catch (e) {
        attempts++;
        if (attempts == maxAttempts) rethrow;
        await Future.delayed(delay * attempts);
      }
    }
    throw Exception('Max retry attempts reached');
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Future<bool> handleError(
    BuildContext context,
    Future<void> Function() operation, {
    String? successMessage,
    String? errorMessage,
  }) async {
    try {
      await operation();
      if (successMessage != null) {
        showSuccessSnackBar(context, successMessage);
      }
      return true;
    } catch (e) {
      debugPrint('Error: $e');
      showErrorSnackBar(
        context,
        errorMessage ?? 'An error occurred. Please try again.',
      );
      return false;
    }
  }
} 