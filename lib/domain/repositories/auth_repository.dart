import 'package:evently/models/my_user.dart';

abstract class AuthRepository {
  /// Signs in with email and password and returns the stored user.
  /// Throws an `AppFailure` on failure.
  Future<MyUser> login({required String email, required String password});

  /// Creates an account, stores the user profile, and returns it.
  /// Throws an `AppFailure` on failure.
  Future<MyUser> register({
    required String name,
    required String email,
    required String password,
  });

  /// Signs in with Google, creating the user profile on first login.
  /// Throws an `AppFailure` on failure.
  Future<MyUser> loginWithGoogle();

  /// Returns true when a Firebase session from a previous launch is still active.
  bool isSignedIn();

  /// Signs out of Firebase and Google.
  Future<void> logout();
}
