import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@lazySingleton
class LocationService {
  final Location _location = Location();

  /// Returns the device location, or null when permission or GPS is unavailable.
  /// May show the system permission/GPS dialogs, so call it from UI-triggered code.
  Future<LatLng?> getCurrentLocation() async {
    try {
      if (!await _hasPermission()) return null;
      if (!await _isServiceEnabled()) return null;
      final LocationData data = await _location.getLocation();
      return LatLng(data.latitude, data.longitude);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Checks the location permission and requests it when denied.
  Future<bool> _hasPermission() async {
    PermissionStatus status = await _location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
    }
    return status == PermissionStatus.granted;
  }

  /// Checks the GPS service and asks the user to enable it when off.
  Future<bool> _isServiceEnabled() async {
    bool isEnabled = await _location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await _location.requestService();
    }
    return isEnabled;
  }
}
