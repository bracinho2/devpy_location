import 'dart:developer';

import 'package:devpy_location/src/coordinates.dart';
import 'package:location/location.dart';

class DevPyLocation {
  const DevPyLocation();

  Future<Coordinates> getUserLocation() async {
    try {
      bool serviceEnabled;
      PermissionStatus permissionStatus;

      permissionStatus = await Location.instance.hasPermission();

      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await Location.instance.requestPermission();

        if (permissionStatus != PermissionStatus.granted) {
          return Coordinates.empty;
        }
      }

      serviceEnabled = await Location.instance.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await Location.instance.requestService();
        if (!serviceEnabled) {
          return Coordinates.empty;
        }
      }

      final currentLocation = await Location.instance.getLocation();

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
