import 'dart:convert';

import 'package:collection/collection.dart';

import 'location.dart';

class Address {
  Location? location;
  String? addressText;
  String? id;

  Address({this.location, this.addressText, this.id});

  @override
  String toString() {
    return 'Address(location: $location, addressText: $addressText, id: $id)';
  }

  factory Address.fromMap(Map<String, dynamic> data) => Address(
    location: data['location'] == null
        ? null
        : Location.fromMap(data['location'] as Map<String, dynamic>),
    addressText: data['addressText'] as String?,
    id: data['_id'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'location': location?.toMap(),
    'addressText': addressText,
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

  Address copyWith({Location? location, String? addressText, String? id}) {
    return Address(
      location: location ?? this.location,
      addressText: addressText ?? this.addressText,
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
  int get hashCode => location.hashCode ^ addressText.hashCode ^ id.hashCode;
}
