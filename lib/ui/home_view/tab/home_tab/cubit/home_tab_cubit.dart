import 'dart:async';

import 'package:evently/domain/repositories/events_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/home_view/tab/home_tab/cubit/home_tab_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit(this._repository) : super(const HomeTabState());

  final EventsRepository _repository;

  StreamSubscription<List<Event>>? _subscription;

  /// Starts listening to all events.
  void watchEvents() {
    _subscription?.cancel();
    emit(state.copyWith(isLoading: true));
    _subscription = _repository.watchAllEvents().listen(
      (events) => emit(state.copyWith(allEvents: events, isLoading: false)),
      onError: (Object error) => emit(
        state.copyWith(isLoading: false, failure: AppFailure.fromError(error)),
      ),
    );
  }

  /// Filters the list by the category tab at [index].
  void selectCategory(int index) {
    emit(state.copyWith(selectedIndex: index, failure: state.failure));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
