import 'package:evently/ui/home_view/tab/map_tab/view_model/map_tab_view_model.dart';
import 'package:evently/ui/home_view/tab/map_tab/widget/map_event_card.dart';
import 'package:evently/ui/home_view/tab/map_tab/widget/map_events_section.dart';
import 'package:evently/ui/home_view/tab/map_tab/widget/map_locate_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/// Full-screen map with the locate button on top and the events list at the bottom.
class MapTabBody extends StatelessWidget {
  const MapTabBody({super.key});

  static const double _edgeSpacing = 16;
  static const double _listBottomSpacing = 32;

  @override
  Widget build(BuildContext context) {
    final MapTabViewModel viewModel = context.read<MapTabViewModel>();
    final Set<Marker> markers = context.select<MapTabViewModel, Set<Marker>>(
      (viewModel) => viewModel.markers,
    );
    final EdgeInsets safePadding = MediaQuery.paddingOf(context);
    final double listBottom = safePadding.bottom + _listBottomSpacing;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: viewModel.cameraPosition,
            onMapCreated: viewModel.attachMap,
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            // Keeps the camera target and the map logo above the events list.
            padding: EdgeInsets.only(
              top: safePadding.top,
              bottom: listBottom + MapEventCard.height,
            ),
          ),
          PositionedDirectional(
            top: safePadding.top + _edgeSpacing,
            end: _edgeSpacing,
            child: MapLocateButton(onPressed: viewModel.locateUser),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: listBottom,
            height: MapEventCard.height,
            child: const MapEventsSection(),
          ),
        ],
      ),
    );
  }
}
