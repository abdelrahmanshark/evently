import 'dart:async';

import 'package:evently/domain/repositories/events_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/home_view/my_events_view/cubit/my_events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyEventsCubit extends Cubit<MyEventsState> {
  MyEventsCubit(this._repository) : super(const MyEventsState());

  final EventsRepository _repository;

  StreamSubscription<List<Event>>? _subscription;
  String _userId = '';

  /// Starts listening to the events created by [userId].
  void watchMyEvents(String userId) {
    _userId = userId;
    _subscription?.cancel();
    emit(MyEventsState(events: state.events, isLoading: true));
    _subscription = _repository
        .watchUserEvents(userId)
        .listen(
          (events) => emit(MyEventsState(events: events)),
          onError: (Object error) => emit(
            MyEventsState(
              events: state.events,
              failure: AppFailure.fromError(error),
            ),
          ),
        );
  }

  /// Listens again after a failure.
  void retry() => watchMyEvents(_userId);

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
