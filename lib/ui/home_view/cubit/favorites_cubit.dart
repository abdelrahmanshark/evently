import 'dart:async';

import 'package:evently/domain/repositories/events_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/home_view/cubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Favorites of the signed-in user, shared by the home and favorite tabs.
@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._repository) : super(const FavoritesState());

  final EventsRepository _repository;

  StreamSubscription<List<Event>>? _subscription;
  String _userId = '';

  /// Starts listening to the favorites of [userId].
  void watchFavorites(String userId) {
    _userId = userId;
    _subscription?.cancel();
    emit(state.copyWith(isLoading: true));
    _subscription = _repository
        .watchFavoriteEvents(userId)
        .listen(
          (favorites) =>
              emit(state.copyWith(favorites: favorites, isLoading: false)),
          onError: (Object error) => emit(
            state.copyWith(
              isLoading: false,
              failure: AppFailure.fromError(error),
            ),
          ),
        );
  }

  /// Listens again after a failure.
  void retry() => watchFavorites(_userId);

  /// Updates the favorites search text.
  void onSearchChanged(String text) {
    emit(state.copyWith(searchText: text, failure: state.failure));
  }

  /// Adds or removes [event]; returns true when it was added.
  Future<bool> toggleFavorite(Event event) async {
    if (state.isFavorite(event.id)) {
      await _repository.removeFromFavorites(_userId, event.id);
      return false;
    }
    await _repository.addToFavorites(_userId, event);
    return true;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
