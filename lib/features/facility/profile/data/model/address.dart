import 'dart:convert';

import 'package:collection/collection.dart';

import 'location.dart';

class Address {
  Location? location;
  String? addressText;
  int? floor;
  String? id;

  Address({this.location, this.addressText, this.floor, this.id});

  @override
  String toString() {
    return 'Address(location: $location, addressText: $addressText, floor: $floor, id: $id)';
  }

  factory Address.fromMap(Map<String, dynamic> data) => Address(
    location: data['location'] == null
        ? null
        : Location.fromMap(data['location'] as Map<String, dynamic>),
    addressText: data['addressText'] as String?,
    floor: data['floor'] as int?,
    id: data['_id'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'location': location?.toMap(),
    'addressText': addressText,
    'floor': floor,
    '_id': id,
  };

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

  Address copyWith({
    Location? location,
    String? addressText,
    int? floor,
    String? id,
  }) {
    return Address(
      location: location ?? this.location,
      addressText: addressText ?? this.addressText,
      floor: floor ?? this.floor,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Address) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      location.hashCode ^ addressText.hashCode ^ floor.hashCode ^ id.hashCode;
}
