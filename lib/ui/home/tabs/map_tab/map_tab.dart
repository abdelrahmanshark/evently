import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../providers/map_provider.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = AppConst(context).mapProvider;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                    initialCameraPosition: mapProvider.cameraPosition,
                  onMapCreated: (controller) {
                    mapProvider.googleMapController =controller;

                  },

                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            await mapProvider.getUserLocation();
          },
      child: Icon(Icons.location_searching_rounded)
        ,),
      floatingActionButtonLocation:FloatingActionButtonLocation.endTop ,
    );
  }
}
