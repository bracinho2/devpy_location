import 'package:geolocator/geolocator.dart';

import '../devpy_location.dart';

/// A utility class for handling user location retrieval.
class DevPyLocation {
  /// Private constructor to prevent instantiation.
  const DevPyLocation._();

  /// Retrieves the current location of the user.
  ///
  /// This method checks whether location services are enabled and requests
  /// the necessary permissions if not already granted. If the permissions
  /// are denied permanently, an error is returned.
  ///
  /// Returns a [Coordinates] object containing latitude and longitude
  /// of the current position.
  ///
  /// Throws an error if location services are disabled or permissions
  /// are denied.
  static Future<Coordinates> getUserLocation() async {
    // Check if location services are enabled.
    if (!await Geolocator.isLocationServiceEnabled()) {
      return Future.error('Location services are disabled.');
    }

    // Check and request location permissions if needed.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied. We cannot request permissions.');
    }

    // Retrieve and return the current position.
    final position = await Geolocator.getCurrentPosition();
    return Coordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
