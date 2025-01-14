import 'package:equatable/equatable.dart';

/// {@template coordinates}
/// Coordinates model
///
/// [Coordinates.empty] represents an empty coordinates.
/// {@endtemplate}
class Coordinates extends Equatable {
  /// {@macro user}
  const Coordinates({
    this.latitude,
    this.longitude,
  });

  /// The current user's latitude
  final String? latitude;

  /// The current user's longitude
  final String? longitude;

  /// Empty coordinates which represents an empty state.
  static const empty = Coordinates(latitude: '', longitude: '');

  /// Convenience getter to determine whether the current coordinates are empty.
  bool get isEmpty => this == Coordinates.empty;

  /// Convenience getter to determine whether the current coordinates are not empty.
  bool get isNotEmpty => this != Coordinates.empty;

  @override
  List<Object?> get props => [latitude, longitude];
}
