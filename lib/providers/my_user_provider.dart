import 'package:evently/domain/repositories/auth_repository.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyUserProvider extends ChangeNotifier {
  MyUserProvider(this._authRepository);

  final AuthRepository _authRepository;

  MyUser? currentUser;

  /// Stores the signed-in user and remembers it for the next app launch.
  Future<void> updateUser(MyUser user) async {
    currentUser = user;
    notifyListeners();
    await saveSignedInUser(user);
  }

  /// Signs out, clears the saved user, and returns to the login screen.
  Future<void> logout(BuildContext context) async {
    await _authRepository.logout();
    await clearSignedInUser();
    currentUser = null;
    notifyListeners();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginRouteName,
      (route) => false,
    );
  }
}
