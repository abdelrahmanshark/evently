/// Failures the UI knows how to describe to the user.
// An enum can implement Exception, so repositories can `throw AppFailure.weakPassword`.
enum AppFailure implements Exception {
  wrongCredentials,
  weakPassword,
  emailAlreadyInUse,
  cancelled,
  unknown;

  /// Converts any caught error into an [AppFailure].
  static AppFailure fromError(Object error) {
    return error is AppFailure ? error : AppFailure.unknown;
  }
}
