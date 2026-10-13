import 'package:evently/data/auth/auth_remote_data_source.dart';
import 'package:evently/data/auth/users_remote_data_source.dart';
import 'package:evently/domain/repositories/auth_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authDataSource, this._usersDataSource);

  final AuthRemoteDataSource _authDataSource;
  final UsersRemoteDataSource _usersDataSource;

  @override
  Future<MyUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final User firebaseUser = await _authDataSource.signInWithEmail(
        email,
        password,
      );
      final MyUser? storedUser = await _usersDataSource.getUser(
        firebaseUser.uid,
      );
      return storedUser ??
          MyUser(
            id: firebaseUser.uid,
            name: firebaseUser.displayName ?? '',
            email: email,
          );
    } catch (e) {
      throw _toFailure(e);
    }
  }

  @override
  Future<MyUser> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final User firebaseUser = await _authDataSource.createAccount(
        email,
        password,
      );
      final MyUser user = MyUser(
        id: firebaseUser.uid,
        name: name,
        email: email,
      );
      await _usersDataSource.saveUser(user);
      return user;
    } catch (e) {
      throw _toFailure(e);
    }
  }

  @override
  Future<MyUser> loginWithGoogle() async {
    try {
      final User firebaseUser = await _authDataSource.signInWithGoogle();
      final MyUser? storedUser = await _usersDataSource.getUser(
        firebaseUser.uid,
      );
      if (storedUser != null) return storedUser;
      final MyUser newUser = MyUser(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? '',
        email: firebaseUser.email ?? '',
      );
      await _usersDataSource.saveUser(newUser);
      return newUser;
    } catch (e) {
      throw _toFailure(e);
    }
  }

  @override
  bool isSignedIn() => _authDataSource.hasSignedInUser();

  @override
  Future<void> logout() {
    return _authDataSource.signOut();
  }

  /// Maps Firebase and Google sign-in errors to an [AppFailure].
  AppFailure _toFailure(Object error) {
    if (error is GoogleSignInException &&
        error.code == GoogleSignInExceptionCode.canceled) {
      return AppFailure.cancelled;
    }
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          return AppFailure.weakPassword;
        case 'email-already-in-use':
          return AppFailure.emailAlreadyInUse;
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
        case 'invalid-email':
        case 'user-disabled':
          return AppFailure.wrongCredentials;
      }
    }
    return AppFailure.unknown;
  }
}
