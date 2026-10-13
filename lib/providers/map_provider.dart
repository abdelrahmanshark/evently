import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapProvider extends ChangeNotifier{
  MapProvider(){
    getUserLocation();
  }
  GoogleMapController? googleMapController ;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );
final Location location = Location();
Future<void> getUserLocation()async {
  bool isPermissionGranted = await _getLocationPermission();
  if(!isPermissionGranted) return;
  bool isGpsServiceEnabled = await _getGpsServiceEnabled();
  if(!isGpsServiceEnabled) return;
  LocationData userLocation = await location.getLocation();
  updateLocation(userLocation);
}


void updateLocation(LocationData userLocation){
  cameraPosition = CameraPosition(
    target: LatLng(userLocation.latitude, userLocation.longitude),
    zoom: 17,
  );
  googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  notifyListeners();
}



 Future<bool> _getLocationPermission()async {
   PermissionStatus permissionStatus = await location.hasPermission();
   if (permissionStatus == PermissionStatus.denied){
     permissionStatus = await location.requestPermission();
   }
   return permissionStatus == PermissionStatus.granted;
 }

 Future<bool> _getGpsServiceEnabled() async{
  bool isServiceEnabled = await location.serviceEnabled();
  if(!isServiceEnabled){
    isServiceEnabled =await location.requestService();
  }
  return isServiceEnabled;
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

//install package
//flutter pub add location
//android permissions
/*
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />*/
/*افتح:

android/settings.gradle

ودور على:

id "org.jetbrains.kotlin.android" version "2.1.0"

وغيّرها إلى:

id "org.jetbrains.kotlin.android" version "2.3.0"

لأن الـ dependency الموجودة عندك مبنية بــ Kotlin metadata 2.3.0*/
/*افتح:

android/app/build.gradle.kts

وروح للسطر 22 تقريبًا. غالبًا هتلاقي:

kotlinOptions {
jvmTarget = JavaVersion.VERSION_11.toString()
}

استبدل البلوك كله بـ:

kotlin {
compilerOptions {
jvmTarget.set(
org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11
)
}
}*/
//ios permissions
/*<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to your location to show nearby stores.</string>*/
//google map install
//flutter pub add google_maps_flutter
//api for android
/*<meta-data android:name="com.google.android.geo.API_KEY"
android:value="YOUR KEY HERE"/>*/
//ios ios/Runner/AppDelegate.swift
/*
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
override func application(
_ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
GMSServices.provideAPIKey("YOUR KEY HERE")
GeneratedPluginRegistrant.register(with: self)
return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
}*/
