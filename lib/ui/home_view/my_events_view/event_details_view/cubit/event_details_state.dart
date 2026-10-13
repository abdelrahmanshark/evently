import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/place_address.dart';

class EventDetailsState {
  const EventDetailsState({
    required this.event,
    this.address,
    this.isAddressLoading = true,
    this.isDeleting = false,
    this.isDeleted = false,
    this.failure,
  });

  final Event event;

  /// Null when the address is loading or unknown.
  final PlaceAddress? address;
  final bool isAddressLoading;
  final bool isDeleting;
  final bool isDeleted;
  final AppFailure? failure;

  /// Returns a copy with the given values; [failure] is cleared unless passed.
  EventDetailsState copyWith({
    Event? event,
    PlaceAddress? address,
    bool? isAddressLoading,
    bool? isDeleting,
    bool? isDeleted,
    AppFailure? failure,
  }) {
    return EventDetailsState(
      event: event ?? this.event,
      address: address ?? this.address,
      isAddressLoading: isAddressLoading ?? this.isAddressLoading,
      isDeleting: isDeleting ?? this.isDeleting,
      isDeleted: isDeleted ?? this.isDeleted,
      failure: failure,
    );
  }
}
