import 'dart:developer';

import 'package:evently/models/place_address.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeocodingService {
  final geocoding.Geocoding _geocoding = geocoding.Geocoding();

  /// Returns the city and country at [location], or null when unknown.
  Future<PlaceAddress?> getAddress(LatLng location) async {
    try {
      final List<geocoding.Placemark> placemarks = await _geocoding
          .placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isEmpty) return null;
      final geocoding.Placemark placemark = placemarks.first;
      return PlaceAddress(
        city:
            placemark.locality ??
            placemark.subAdministrativeArea ??
            placemark.administrativeArea ??
            'Unknown',
        country: placemark.country ?? 'Unknown',
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
