import 'dart:developer';

import 'package:devpy_location/src/coordinates.dart';
import 'package:location/location.dart';

abstract class DevPyLocation {
  Future<Coordinates> getUserLocation();
}

class LocationService implements DevPyLocation {
  final location = Location();
  @override
  Future<Coordinates> getUserLocation() async {
    try {
      bool serviceEnabled;
      PermissionStatus permissionGranted;

      permissionGranted = await location.hasPermission();

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();

        if (permissionGranted != PermissionStatus.granted) {
          return Coordinates.empty;
        }
      }

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return Coordinates.empty;
        }
      }

      final currentLocation = await location.getLocation();

      return Coordinates(
          latitude: currentLocation.latitude.toString(),
          longitude: currentLocation.longitude.toString());
    } catch (e) {
      log(e.toString());
      log(StackTrace.current.toString());
      return Coordinates.empty;
    }
  }
}
