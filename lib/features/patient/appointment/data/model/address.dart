import 'dart:convert';

import 'package:collection/collection.dart';

import 'location.dart';

class Address {
  Location? location;

  Address({this.location});

  @override
  String toString() => 'Address(location: $location)';

  factory Address.fromMap(Map<String, dynamic> data) => Address(
    location: data['location'] == null
        ? null
        : Location.fromMap(data['location'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {'location': location?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Address].
  factory Address.fromJson(String data) {
    return Address.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Address] to a JSON string.
  String toJson() => json.encode(toMap());

  Address copyWith({Location? location}) {
    return Address(location: location ?? this.location);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Address) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => location.hashCode;
}
