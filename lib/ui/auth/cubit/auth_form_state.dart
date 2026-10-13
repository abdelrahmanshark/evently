import 'package:evently/models/app_failure.dart';
import 'package:evently/models/my_user.dart';

/// Shared by the login and register cubits.
class AuthFormState {
  const AuthFormState({this.isLoading = false, this.failure, this.user});

  final bool isLoading;
  final AppFailure? failure;

  /// Set once the user is signed in.
  final MyUser? user;
}
