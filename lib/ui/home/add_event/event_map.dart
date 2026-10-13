import 'package:evently/providers/event_map_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMap extends StatefulWidget {
  PickLocationProvider pickLocationProvider ;
    EventMap({super.key,required this.pickLocationProvider});

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  @override
  Widget build(BuildContext context) {
    var appConst = AppConst(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentGeometry.bottomCenter,
              children: [
                GoogleMap(
                  initialCameraPosition: widget.pickLocationProvider.cameraPosition,
                  onMapCreated: (controller) {
                    widget.pickLocationProvider.googleMapController =controller;

                  },
                  markers: widget.pickLocationProvider.markers,
                  onTap: (location) async {
                    debugPrint('MAP TAPPED');
                    await widget.pickLocationProvider.pickLocation(location);
                    setState(() {

                    });
                  },
                ),

                Container(
                  width: double.infinity,
                  height: appConst.height*.06,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor
                  ),
                  child: Text(
                      appConst.text.tap_on_location_to_select,
                  textAlign: TextAlign.center,
                    style: AppStyles.whiteMed16,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await widget.pickLocationProvider.getUserLocation();
        },
        child: Icon(Icons.location_searching_rounded)
        ,),
      floatingActionButtonLocation:FloatingActionButtonLocation.endTop ,
    );
  }
}
