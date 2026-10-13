import 'package:evently/l10n/app_localizations.dart';

class AppValidators {
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// Returns [message] when [text] is empty, otherwise null.
  static String? required(String? text, String message) {
    if (text == null || text.trim().isEmpty) return message;
    return null;
  }

  /// Validates a required, well-formed email.
  static String? email(String? text, AppLocalizations l10n) {
    if (text == null || text.trim().isEmpty) {
      return l10n.please_enter_an_email;
    }
    if (!_emailRegExp.hasMatch(text.trim())) {
      return l10n.please_enter_a_valid_email;
    }
    return null;
  }

  /// Validates a required password of at least 6 characters.
  static String? password(String? text, AppLocalizations l10n) {
    if (text == null || text.trim().isEmpty) {
      return l10n.please_enter_a_password;
    }
    if (text.length < 6) {
      return l10n.password_must_be_at_least_6_char;
    }
    return null;
  }

  /// Validates that [text] matches the already entered [password].
  static String? confirmPassword(
    String? text,
    String password,
    AppLocalizations l10n,
  ) {
    if (text == null || text.trim().isEmpty) {
      return l10n.please_enter_a_password;
    }
    if (text != password) {
      return l10n.re_password_dosnt_match;
    }
    return null;
  }
}
