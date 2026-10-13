import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home_view/add_event_view/view_model/pick_location_view_model.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/// Map where the user taps to pick the event location.
/// Needs the add-event screen's [PickLocationViewModel] above it.
class EventMapView extends StatefulWidget {
  const EventMapView({super.key});

  @override
  State<EventMapView> createState() => _EventMapViewState();
}

class _EventMapViewState extends State<EventMapView> {
  late final PickLocationViewModel _viewModel = context
      .read<PickLocationViewModel>();

  @override
  void dispose() {
    // The view model outlives this map, so it must drop the disposed controller.
    _viewModel.detachMap();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = context.select<PickLocationViewModel, Set<Marker>>(
      (viewModel) => viewModel.markers,
    );
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GoogleMap(
            initialCameraPosition: _viewModel.cameraPosition,
            onMapCreated: _viewModel.attachMap,
            markers: markers,
            onTap: _viewModel.pickLocation,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * .06,
            color: AppColors.primaryColor,
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.tap_on_location_to_select,
              textAlign: TextAlign.center,
              style: AppStyles.whiteMed16,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewModel.locateUser,
        child: const Icon(Icons.location_searching_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
