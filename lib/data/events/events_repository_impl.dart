import 'package:evently/data/events/events_remote_data_source.dart';
import 'package:evently/domain/repositories/events_repository.dart';
import 'package:evently/models/event.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EventsRepository)
class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl(this._dataSource);

  final EventsRemoteDataSource _dataSource;

  @override
  Stream<List<Event>> watchAllEvents() {
    return _dataSource.watchEvents().map((events) {
      events.sort((first, second) => first.date.compareTo(second.date));
      return events;
    });
  }

  @override
  Stream<List<Event>> watchUserEvents(String userId) {
    return _dataSource.watchUserEvents(userId);
  }

  @override
  Stream<List<Event>> watchFavoriteEvents(String userId) {
    return _dataSource.watchFavoriteEvents(userId);
  }

  @override
  Stream<Event?> watchUserEvent(String userId, String eventId) {
    return _dataSource.watchUserEvent(userId, eventId);
  }

  @override
  Future<void> addEvent(String userId, Event event) async {
    final Event savedEvent = await _dataSource.addEvent(event);
    await _dataSource.addUserEvent(userId, savedEvent);
  }

  @override
  Future<void> updateEvent(String userId, Event event) async {
    await _dataSource.updateEvent(event);
    await _dataSource.addUserEvent(userId, event);
  }

  @override
  Future<void> deleteEvent(String userId, String eventId) async {
    await _dataSource.deleteEvent(eventId);
    await _dataSource.deleteUserEvent(userId, eventId);
    await _dataSource.removeFavorite(userId, eventId);
  }

  @override
  Future<void> addToFavorites(String userId, Event event) {
    return _dataSource.addFavorite(userId, event);
  }

  @override
  Future<void> removeFromFavorites(String userId, String eventId) {
    return _dataSource.removeFavorite(userId, eventId);
  }
}
