import 'dart:convert';

import 'package:collection/collection.dart';

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  @override
  String toString() => 'Location(type: $type, coordinates: $coordinates)';

  factory Location.fromMap(Map<String, dynamic> data) => Location(
    type: data['type'] as String?,
    coordinates: data['coordinates'] as List<double>?,
  );

  Map<String, dynamic> toMap() => {'type': type, 'coordinates': coordinates};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Location].
  factory Location.fromJson(String data) {
    return Location.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Location] to a JSON string.
  String toJson() => json.encode(toMap());

  Location copyWith({String? type, List<double>? coordinates}) {
    return Location(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Location) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}
