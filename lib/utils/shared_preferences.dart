import 'dart:convert';

import 'package:evently/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  // The stored value is `true` until the intro is finished (kept for existing installs).
  static const String showIntro = 'is Seen';
  static const String languageCode = 'local';
  static const String themeMode = 'Theme';
  static const String signedInUser = 'signedInUser';
}

/// Returns true when the onboarding intro still has to be shown.
Future<bool> getShouldShowIntro() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(SharedPreferencesKeys.showIntro) ?? true;
}

/// Remembers that the user finished the onboarding intro.
Future<void> saveIntroCompleted() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(SharedPreferencesKeys.showIntro, false);
}

/// Returns the saved language code, or 'en'.
Future<String> getLanguageCode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPreferencesKeys.languageCode) ?? 'en';
}

/// Saves the selected language code.
Future<void> saveLanguageCode(String languageCode) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(SharedPreferencesKeys.languageCode, languageCode);
}

/// Returns the saved theme mode, or light.
Future<ThemeMode> getThemeMode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String theme = prefs.getString(SharedPreferencesKeys.themeMode) ?? 'light';
  return theme == 'light' ? ThemeMode.light : ThemeMode.dark;
}

/// Saves the selected theme mode.
Future<void> saveThemeMode(ThemeMode themeMode) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(
    SharedPreferencesKeys.themeMode,
    themeMode == ThemeMode.light ? 'light' : 'dark',
  );
}

/// Returns the user saved at the last sign-in, or null if nobody is signed in.
Future<MyUser?> getSignedInUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userJson = prefs.getString(SharedPreferencesKeys.signedInUser);
  if (userJson == null) return null;
  return MyUser.fromFirestore(jsonDecode(userJson) as Map<String, dynamic>);
}

/// Saves the signed-in user so the next app launch skips the login screen.
Future<void> saveSignedInUser(MyUser user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(
    SharedPreferencesKeys.signedInUser,
    jsonEncode(user.toFirestore()),
  );
}

/// Removes the saved user after logout.
Future<void> clearSignedInUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(SharedPreferencesKeys.signedInUser);
}
