import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'app_exception.dart';

abstract final class ErrorHandler {
  static String userMessage(Object error) {
    if (error is AppException) {
      return error.message;
    }

    if (error is FirebaseAuthException) {
      return switch (error.code) {
        'user-not-found' => 'No account found with this email.',
        'wrong-password' => 'Incorrect password.',
        'user-disabled' => 'This account has been disabled.',
        'network-request-failed' => 'Network error. Check your connection.',
        _ => 'Authentication error. Please try again.',
      };
    }

    return 'Something went wrong. Please try again.';
  }

  static void logError(Object error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('Error: $error');
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }
}
