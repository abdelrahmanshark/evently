import 'dart:async';

import 'package:evently/domain/repositories/events_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/place_address.dart';
import 'package:evently/services/geocoding_service.dart';
import 'package:evently/ui/home_view/view_model/user_location_view_model.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/map_marker_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

/// Map camera (from [UserLocationViewModel]) plus the events shown on the map.
@injectable
class MapTabViewModel extends UserLocationViewModel {
  MapTabViewModel(
    super.locationService,
    this._eventsRepository,
    this._geocodingService,
  );

  final EventsRepository _eventsRepository;
  final GeocodingService _geocodingService;

  StreamSubscription<List<Event>>? _subscription;
  BitmapDescriptor? _markerIcon;
  BitmapDescriptor? _selectedMarkerIcon;
  final Set<String> _requestedAddressIds = {};

  List<Event> events = [];
  bool isLoading = false;
  AppFailure? failure;
  String? selectedEventId;
  Set<Marker> markers = {};

  /// Looked-up addresses by event id; a null value means the address is unknown.
  final Map<String, PlaceAddress?> addresses = {};

  /// Index of the selected event in [events], or null when none is selected.
  int? get selectedIndex {
    final int index = events.indexWhere((event) => event.id == selectedEventId);
    return index == -1 ? null : index;
  }

  /// Draws the event marker icons, then shows the markers.
  Future<void> loadMarkerIcons() async {
    _markerIcon = await MapMarkerIcons.dot(
      haloColor: AppColors.grayColor.withValues(alpha: 0.35),
      dotColor: AppColors.blackColor,
    );
    _selectedMarkerIcon = await MapMarkerIcons.dot(
      haloColor: AppColors.primaryColor.withValues(alpha: 0.3),
      dotColor: AppColors.primaryColor,
      ringColor: AppColors.primaryLightColor,
    );
    _rebuildMarkers();
    notifyIfActive();
  }

  /// Starts listening to all events.
  void watchEvents() {
    _subscription?.cancel();
    isLoading = true;
    failure = null;
    notifyIfActive();
    _subscription = _eventsRepository.watchAllEvents().listen(
      _onEvents,
      onError: _onError,
    );
  }

  /// Highlights [event] and moves the camera to its location.
  void selectEvent(Event event) {
    selectedEventId = event.id;
    _rebuildMarkers();
    moveCameraTo(_positionOf(event));
    notifyIfActive();
  }

  /// Shows the latest [newEvents] and looks up their addresses.
  void _onEvents(List<Event> newEvents) {
    events = newEvents;
    isLoading = false;
    failure = null;
    if (selectedIndex == null) selectedEventId = null;
    _rebuildMarkers();
    notifyIfActive();
    _loadMissingAddresses();
  }

  /// Shows a failure instead of the events.
  void _onError(Object error) {
    isLoading = false;
    failure = AppFailure.fromError(error);
    notifyIfActive();
  }

  /// Looks up, one by one, the addresses of events not looked up yet.
  Future<void> _loadMissingAddresses() async {
    for (final Event event in events) {
      // `add` returns false when the id was already requested.
      if (!_requestedAddressIds.add(event.id)) continue;
      addresses[event.id] = await _geocodingService.getAddress(
        _positionOf(event),
      );
      notifyIfActive();
    }
  }

  /// Creates one marker per event; the selected one uses the primary color.
  /// Stays empty until the icons are drawn, so default pins never flash.
  void _rebuildMarkers() {
    final BitmapDescriptor? markerIcon = _markerIcon;
    final BitmapDescriptor? selectedMarkerIcon = _selectedMarkerIcon;
    if (markerIcon == null || selectedMarkerIcon == null) return;
    markers = {
      for (final Event event in events)
        Marker(
          markerId: MarkerId(event.id),
          position: _positionOf(event),
          icon: event.id == selectedEventId ? selectedMarkerIcon : markerIcon,
          // The icon is a dot, so its center (not its bottom) sits on the location.
          anchor: const Offset(0.5, 0.5),
          consumeTapEvents: true,
          onTap: () => selectEvent(event),
        ),
    };
  }

  /// Returns the map position of [event].
  LatLng _positionOf(Event event) => LatLng(event.latitude, event.longitude);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
