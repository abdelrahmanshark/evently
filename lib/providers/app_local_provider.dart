import 'package:evently/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppLocalProvider extends ChangeNotifier {
  AppLocalProvider(this.appLocal);

  /// Current language code: `en` or `ar`.
  String appLocal;

  bool get isEnglish => appLocal == 'en';

  /// Switches the app language and saves it.
  Future<void> changeLanguage(String newLanguage) async {
    if (appLocal == newLanguage) return;
    appLocal = newLanguage;
    notifyListeners();
    await saveLanguageCode(newLanguage);
  }
}
