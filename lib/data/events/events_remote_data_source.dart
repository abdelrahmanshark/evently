import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/data/auth/users_remote_data_source.dart';
import 'package:evently/models/event.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EventsRemoteDataSource {
  static const String _eventsCollectionKey = 'Events';
  static const String _userEventsCollectionKey = 'User Events';
  static const String _userFavoritesCollectionKey = 'User Favorite Events';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Emits the public events whenever they change.
  Stream<List<Event>> watchEvents() {
    return _toEventsStream(
      _typedEvents(_firestore.collection(_eventsCollectionKey)),
    );
  }

  /// Emits the events created by [userId] whenever they change.
  Stream<List<Event>> watchUserEvents(String userId) {
    return _toEventsStream(_userEvents(userId));
  }

  /// Emits the favorite events of [userId] whenever they change.
  Stream<List<Event>> watchFavoriteEvents(String userId) {
    return _toEventsStream(_userFavorites(userId));
  }

  /// Saves [event] to the public list with a new id and returns it.
  Future<Event> addEvent(Event event) async {
    try {
      final DocumentReference<Event> doc = _typedEvents(
        _firestore.collection(_eventsCollectionKey),
      ).doc();
      final Event savedEvent = event.copyWith(id: doc.id);
      await doc.set(savedEvent);
      return savedEvent;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Emits the event with [eventId] created by [userId], or null once it's deleted.
  Stream<Event?> watchUserEvent(String userId, String eventId) {
    return _userEvents(
      userId,
    ).doc(eventId).snapshots().map((snapshot) => snapshot.data());
  }

  /// Overwrites the public copy of [event] (matched by its id).
  Future<void> updateEvent(Event event) async {
    try {
      await _typedEvents(
        _firestore.collection(_eventsCollectionKey),
      ).doc(event.id).set(event);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Deletes the public event with [eventId].
  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection(_eventsCollectionKey).doc(eventId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Deletes the event with [eventId] from the events of [userId].
  Future<void> deleteUserEvent(String userId, String eventId) async {
    try {
      await _userEvents(userId).doc(eventId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Saves [event] (keeping its id) to the events of [userId].
  Future<void> addUserEvent(String userId, Event event) async {
    try {
      await _userEvents(userId).doc(event.id).set(event);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Saves [event] to the favorites of [userId].
  Future<void> addFavorite(String userId, Event event) async {
    try {
      await _userFavorites(userId).doc(event.id).set(event);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Deletes the event with [eventId] from the favorites of [userId].
  Future<void> removeFavorite(String userId, String eventId) async {
    try {
      await _userFavorites(userId).doc(eventId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// The events sub-collection of [userId].
  CollectionReference<Event> _userEvents(String userId) {
    return _typedEvents(_userDoc(userId).collection(_userEventsCollectionKey));
  }

  /// The favorites sub-collection of [userId].
  CollectionReference<Event> _userFavorites(String userId) {
    return _typedEvents(
      _userDoc(userId).collection(_userFavoritesCollectionKey),
    );
  }

  /// The raw profile document of [userId].
  DocumentReference<Map<String, dynamic>> _userDoc(String userId) {
    return _firestore
        .collection(UsersRemoteDataSource.usersCollectionKey)
        .doc(userId);
  }

  /// Adds the [Event] converter to a raw collection.
  CollectionReference<Event> _typedEvents(
    CollectionReference<Map<String, dynamic>> collection,
  ) {
    return collection.withConverter<Event>(
      fromFirestore: (snapshot, options) =>
          Event.fromFirestore(snapshot.data()!),
      toFirestore: (event, options) => event.toFirestore(),
    );
  }

  /// Maps a collection's snapshots to plain event lists.
  Stream<List<Event>> _toEventsStream(CollectionReference<Event> collection) {
    return collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }
}
