import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';

class MyEventsState {
  const MyEventsState({
    this.events = const [],
    this.isLoading = false,
    this.failure,
  });

  final List<Event> events;
  final bool isLoading;
  final AppFailure? failure;
}
