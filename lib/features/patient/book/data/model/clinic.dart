import 'dart:convert';

import 'package:collection/collection.dart';

import 'default_schedule.dart';
import 'location.dart';

class Clinic {
  String? id;
  String? name;
  String? city;
  String? address;
  int? price;
  Location? location;
  DefaultSchedule? defaultSchedule;

  Clinic({
    this.id,
    this.name,
    this.city,
    this.address,
    this.price,
    this.location,
    this.defaultSchedule,
  });

  @override
  String toString() {
    return 'Clinic(id: $id, name: $name, city: $city, address: $address, price: $price, location: $location, defaultSchedule: $defaultSchedule)';
  }

  factory Clinic.fromMap(Map<String, dynamic> data) => Clinic(
    id: data['_id'] as String?,
    name: data['name'] as String?,
    city: data['city'] as String?,
    address: data['address'] as String?,
    price: data['price'] as int?,
    location: data['location'] == null
        ? null
        : Location.fromMap(data['location'] as Map<String, dynamic>),
    defaultSchedule: data['defaultSchedule'] == null
        ? null
        : DefaultSchedule.fromMap(
            data['defaultSchedule'] as Map<String, dynamic>,
          ),
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'name': name,
    'city': city,
    'address': address,
    'price': price,
    'location': location?.toMap(),
    'defaultSchedule': defaultSchedule?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Clinic].
  factory Clinic.fromJson(String data) {
    return Clinic.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Clinic] to a JSON string.
  String toJson() => json.encode(toMap());

  Clinic copyWith({
    String? id,
    String? name,
    String? city,
    String? address,
    int? price,
    Location? location,
    DefaultSchedule? defaultSchedule,
  }) {
    return Clinic(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      address: address ?? this.address,
      price: price ?? this.price,
      location: location ?? this.location,
      defaultSchedule: defaultSchedule ?? this.defaultSchedule,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Clinic) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      city.hashCode ^
      address.hashCode ^
      price.hashCode ^
      location.hashCode ^
      defaultSchedule.hashCode;
}
