import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/map_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Square, non-interactive map preview with a marker on [location].
class EventLocationMap extends StatelessWidget {
  const EventLocationMap({super.key, required this.location});

  final LatLng location;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(16);
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        foregroundDecoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: GoogleMap(
            // A new key recreates the map, because its initial camera can't change later.
            key: ValueKey(location),
            initialCameraPosition: CameraPosition(
              target: location,
              zoom: MapConstants.defaultZoom,
            ),
            markers: {
              Marker(markerId: const MarkerId('event'), position: location),
            },
            liteModeEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
          ),
        ),
      ),
    );
  }
}
