import 'package:evently/di/injection.dart';
import 'package:evently/ui/home_view/tab/map_tab/view_model/map_tab_view_model.dart';
import 'package:evently/ui/home_view/tab/map_tab/widget/map_tab_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // `..` (cascade) creates the view model, then starts locating and loading.
      create: (_) => getIt<MapTabViewModel>()
        ..locateUser()
        ..loadMarkerIcons()
        ..watchEvents(),
      child: const MapTabBody(),
    );
  }
}
