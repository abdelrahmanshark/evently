import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapConstants {
  static const double defaultZoom = 17;

  /// Shown until the user's real location is known.
  static const CameraPosition defaultCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: defaultZoom,
  );
}
