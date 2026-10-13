import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/app_failure.dart';

class FailureMessages {
  /// Returns the translated, user-facing text for [failure].
  static String messageFor(AppLocalizations l10n, AppFailure failure) {
    switch (failure) {
      case AppFailure.wrongCredentials:
        return l10n.wrong_email_or_password;
      case AppFailure.weakPassword:
        return l10n.the_password_provided_is_too_weak;
      case AppFailure.emailAlreadyInUse:
        return l10n.the_account_already_exists_for_that_email;
      case AppFailure.cancelled:
      case AppFailure.unknown:
        return l10n.something_went_wrong;
    }
  }
}
