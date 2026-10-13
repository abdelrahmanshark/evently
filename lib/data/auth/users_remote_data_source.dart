import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/my_user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UsersRemoteDataSource {
  static const String usersCollectionKey = 'my users';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// The typed `my users` collection.
  CollectionReference<MyUser> usersCollection() {
    return _firestore
        .collection(usersCollectionKey)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFirestore(snapshot.data()!),
          toFirestore: (user, options) => user.toFirestore(),
        );
  }

  /// Returns the stored profile for [userId], or null if none exists.
  Future<MyUser?> getUser(String userId) async {
    try {
      final DocumentSnapshot<MyUser> doc = await usersCollection()
          .doc(userId)
          .get();
      return doc.data();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Creates or overwrites the stored profile of [user].
  Future<void> saveUser(MyUser user) async {
    try {
      await usersCollection().doc(user.id).set(user);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
