import 'package:evently/services/location_service.dart';
import 'package:evently/utils/map_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

/// Keeps a map camera centered on the user's location.
@injectable
class UserLocationViewModel extends ChangeNotifier {
  UserLocationViewModel(this._locationService);

  final LocationService _locationService;

  GoogleMapController? _mapController;
  bool _isDisposed = false;

  CameraPosition cameraPosition = MapConstants.defaultCameraPosition;

  /// Remembers the controller of the visible map and syncs its camera.
  void attachMap(GoogleMapController controller) {
    _mapController = controller;
    // The location may have arrived before the map was created.
    controller.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  /// Forgets the map controller when its map leaves the screen.
  void detachMap() {
    _mapController = null;
  }

  /// Moves the camera to the user's current location.
  Future<void> locateUser() async {
    final LatLng? userLocation = await _locationService.getCurrentLocation();
    if (userLocation == null || _isDisposed) return;
    moveCameraTo(userLocation);
    notifyListeners();
  }

  /// Animates the camera to [target] and remembers it for a recreated map.
  void moveCameraTo(LatLng target) {
    cameraPosition = CameraPosition(
      target: target,
      zoom: MapConstants.defaultZoom,
    );
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  /// Notifies listeners unless this view model was already disposed.
  void notifyIfActive() {
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
