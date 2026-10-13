import 'dart:async';

import 'package:evently/domain/repositories/events_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/place_address.dart';
import 'package:evently/services/geocoding_service.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/cubit/event_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit(
    this._repository,
    this._geocodingService,
    @factoryParam Event event,
  ) : super(EventDetailsState(event: event));

  final EventsRepository _repository;
  final GeocodingService _geocodingService;

  StreamSubscription<Event?>? _subscription;
  String _userId = '';

  /// Looks up the address, then keeps the event in sync with its saved copy of [userId].
  void watchEvent(String userId) {
    _userId = userId;
    _loadAddress();
    _subscription?.cancel();
    _subscription = _repository
        .watchUserEvent(userId, state.event.id)
        .listen(_onEvent);
  }

  /// Deletes the event from Firestore.
  Future<void> deleteEvent() async {
    if (state.isDeleting) return;
    emit(state.copyWith(isDeleting: true));
    try {
      await _repository.deleteEvent(_userId, state.event.id);
      if (isClosed) return;
      emit(state.copyWith(isDeleting: false, isDeleted: true));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isDeleting: false, failure: AppFailure.fromError(e)));
    }
  }

  /// Shows the latest saved [event]; a null event means it was deleted.
  void _onEvent(Event? event) {
    if (event == null || isClosed) return;
    final bool hasMoved =
        event.latitude != state.event.latitude ||
        event.longitude != state.event.longitude;
    emit(state.copyWith(event: event));
    if (hasMoved) _loadAddress();
  }

  /// Looks up the city and country of the event location.
  Future<void> _loadAddress() async {
    emit(state.copyWith(isAddressLoading: true));
    final PlaceAddress? address = await _geocodingService.getAddress(
      LatLng(state.event.latitude, state.event.longitude),
    );
    if (isClosed) return;
    emit(
      EventDetailsState(
        event: state.event,
        address: address,
        isAddressLoading: false,
        isDeleting: state.isDeleting,
        isDeleted: state.isDeleted,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
