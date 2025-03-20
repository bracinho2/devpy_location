import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// {@template coordinates}
/// Coordinates model
///
/// [Coordinates.empty] represents an empty coordinates.
/// {@endtemplate}
class Coordinates extends Equatable {
  /// {@macro user}
  const Coordinates._({
    this.latitude,
    this.longitude,
  });

  /// The current user's latitude
  final double? latitude;

  /// The current user's longitude
  final double? longitude;

  /// Factory constructor to create an instance of [Coordinates].
  factory Coordinates({
    required double latitude,
    required double longitude,
  }) {
    return Coordinates._(
      latitude: latitude,
      longitude: longitude,
    );
  }

  /// Empty coordinates which represents an empty state.
  static var empty = Coordinates(latitude: 0.0, longitude: 0.0);

  /// Convenience getter to determine whether the current coordinates are empty.
  bool get isEmpty => this == Coordinates.empty;

  /// Convenience getter to determine whether the current coordinates are not empty.
  bool get isNotEmpty => this != Coordinates.empty;

  /// Converts Coordinates to LatLng.
  LatLng toLatLng() {
    if (latitude == null || longitude == null) {
      throw ArgumentError('Latitude and Longitude must not be null');
    }
    return LatLng(latitude!, longitude!);
  }

  /// Creates a Coordinates instance from LatLng.
  factory Coordinates.fromLatLng(LatLng latLng) {
    return Coordinates(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
    );
  }

  /// Calculates the distance in kilometers to another Coordinates instance.
  double distanceInKm({required Coordinates to}) {
    final Distance distance = Distance();
    return distance.as(
      LengthUnit.Kilometer,
      toLatLng(),
      to.toLatLng(),
    );
  }

  /// Calculates the distance in meters to another Coordinates instance.
  double distanceInMeters({required Coordinates to}) {
    final Distance distance = Distance();
    return distance.as(
      LengthUnit.Meter,
      toLatLng(),
      to.toLatLng(),
    );
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
