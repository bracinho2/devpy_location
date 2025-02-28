import 'dart:developer';

import 'package:devpy_location/src/coordinates.dart';
import 'package:location/location.dart';

class DevPyLocation {
  DevPyLocation._();

  final location = Location();

  Future<Coordinates> getUserLocation() async {
    try {
      bool serviceEnabled;
      PermissionStatus permissionStatus;

      permissionStatus = await location.hasPermission();

      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();

        if (permissionStatus != PermissionStatus.granted) {
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
