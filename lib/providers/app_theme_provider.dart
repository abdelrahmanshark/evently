import 'package:evently/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  AppThemeProvider(this.appTheme);

  ThemeMode appTheme;

  bool get isLight => appTheme == ThemeMode.light;

  /// Switches the app theme and saves it.
  Future<void> changeAppTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) return;
    appTheme = newTheme;
    notifyListeners();
    await saveThemeMode(newTheme);
  }
}
