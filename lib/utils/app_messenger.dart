import 'package:flutter/material.dart';

class AppMessenger {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Shows a floating snackbar from anywhere in the app.
  static void showSnackBar(String message, {Color? backgroundColor}) {
    final ScaffoldMessengerState? messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
