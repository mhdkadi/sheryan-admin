import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  final Location location = Location();
  LocationService._internal();
  static LocationService instance = LocationService._internal();
  Future<LatLng> getCurrentLocation() async {
    try {
      final bool shouldAwait = await checkLocationEnable();
      if (shouldAwait) {
        await Future.delayed(const Duration(seconds: 2));
      }
      final LocationData locationData = await location.getLocation();
      return LatLng(
          locationData.latitude ?? 36.0, locationData.longitude ?? 36.0);
    } catch (e) {
      return const LatLng(36.0, 36.0);
    }
  }

  Future<bool> checkLocationEnable() async {
    try {
      bool shouldAwait = false;
      final Location location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      PermissionStatus permissionGranted = await location.hasPermission();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService().then((value) {
          return value;
        });
        shouldAwait = true;
      }
      if (permissionGranted == PermissionStatus.denied ||
          permissionGranted == PermissionStatus.deniedForever) {
        permissionGranted = await location.requestPermission();
      }
      if (serviceEnabled &&
          (permissionGranted == PermissionStatus.granted ||
              permissionGranted == PermissionStatus.grantedLimited)) {
      } else {
        await checkLocationEnable();
        shouldAwait = true;
      }
      return shouldAwait;
    } catch (e) {
      return false;
    }
  }

  static StreamSubscription<LocationData>? locationSubscription;
  void onChangeLocaltion(void Function(LocationData location) callback) {
    locationSubscription = location.onLocationChanged.listen((event) {
      if (locationSubscription != null) {
        callback(event);
      }
    });
  }

  void cancelOnChangeLocaltion(void Function() callback) async {
    if (locationSubscription != null) {
      await locationSubscription!.cancel();
      locationSubscription = null;
      callback();
    }
  }
}
