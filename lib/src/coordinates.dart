import 'package:equatable/equatable.dart';

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
  final String? latitude;

  /// The current user's longitude
  final String? longitude;

  /// Factory constructor to create an instance of [Coordinates].
  factory Coordinates({
    required String latitude,
    required String longitude,
  }) {
    return Coordinates._(
      latitude: latitude,
      longitude: longitude,
    );
  }

  /// Empty coordinates which represents an empty state.
  static var empty = Coordinates(latitude: '', longitude: '');

  /// Convenience getter to determine whether the current coordinates are empty.
  bool get isEmpty => this == Coordinates.empty;

  /// Convenience getter to determine whether the current coordinates are not empty.
  bool get isNotEmpty => this != Coordinates.empty;

  @override
  List<Object?> get props => [latitude, longitude];
}
