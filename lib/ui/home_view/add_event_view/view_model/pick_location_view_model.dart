import 'package:evently/models/place_address.dart';
import 'package:evently/services/geocoding_service.dart';
import 'package:evently/ui/home_view/view_model/user_location_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

/// Map camera (from [UserLocationViewModel]) plus the picked event location.
@injectable
class PickLocationViewModel extends UserLocationViewModel {
  PickLocationViewModel(super.locationService, this._geocodingService);

  final GeocodingService _geocodingService;

  LatLng? eventLocation;
  PlaceAddress? address;
  Set<Marker> markers = {};

  /// Starts with [location] already picked and the camera on it.
  void startAt(LatLng location) {
    moveCameraTo(location);
    pickLocation(location);
  }

  /// Marks [location] as the event location and looks up its address.
  Future<void> pickLocation(LatLng location) async {
    eventLocation = location;
    markers = {Marker(markerId: const MarkerId('event'), position: location)};
    notifyIfActive();
    address = await _geocodingService.getAddress(location);
    notifyIfActive();
  }
}
