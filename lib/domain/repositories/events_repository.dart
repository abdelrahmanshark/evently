import 'package:evently/models/event.dart';

abstract class EventsRepository {
  /// Emits all events, sorted by date, whenever they change.
  Stream<List<Event>> watchAllEvents();

  /// Emits the events created by [userId] whenever they change.
  Stream<List<Event>> watchUserEvents(String userId);

  /// Emits the favorite events of [userId] whenever they change.
  Stream<List<Event>> watchFavoriteEvents(String userId);

  /// Emits the event with [eventId] created by [userId], or null once it's deleted.
  Stream<Event?> watchUserEvent(String userId, String eventId);

  /// Saves [event] to the public list and to the events of [userId].
  Future<void> addEvent(String userId, Event event);

  /// Saves the edited [event] to the public list and to the events of [userId].
  Future<void> updateEvent(String userId, Event event);

  /// Deletes the event with [eventId] from the public list, the events of [userId],
  /// and the favorites of [userId].
  Future<void> deleteEvent(String userId, String eventId);

  /// Adds [event] to the favorites of [userId].
  Future<void> addToFavorites(String userId, Event event);

  /// Removes the event with [eventId] from the favorites of [userId].
  Future<void> removeFromFavorites(String userId, String eventId);
}
