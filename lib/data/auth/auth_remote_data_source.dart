import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRemoteDataSource {
  static const String _googleServerClientId =
      '1063048862972-tsi1oacc1galrbuvsrbcbin3q6422tea.apps.googleusercontent.com';
  static const List<String> _googleScopes = [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleInitialized = false;

  /// Returns true when Firebase still has a signed-in session on this device.
  bool hasSignedInUser() => _firebaseAuth.currentUser != null;

  /// Signs in with email and password and returns the Firebase user.
  Future<User> signInWithEmail(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Creates an email/password account and returns the Firebase user.
  Future<User> createAccount(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Runs the Google sign-in flow and returns the Firebase user.
  Future<User> signInWithGoogle() async {
    try {
      // GoogleSignIn.initialize must run exactly once per app session.
      if (!_isGoogleInitialized) {
        await _googleSignIn.initialize(serverClientId: _googleServerClientId);
        _isGoogleInitialized = true;
      }
      final GoogleSignInAccount account = await _googleSignIn.authenticate();
      final GoogleSignInClientAuthorization? authorization = await account
          .authorizationClient
          .authorizationForScopes(_googleScopes);
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: account.authentication.idToken,
      );
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      return userCredential.user!;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Signs out of Firebase and Google.
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
