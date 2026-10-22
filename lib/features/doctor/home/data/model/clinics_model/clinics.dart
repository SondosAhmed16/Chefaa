import 'dart:convert';

import 'package:chefaa/features/doctor/home/data/model/clinic_model/default_schedule.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/location.dart';
import 'package:collection/collection.dart';

class Clinics {
  String? id;
  String? name;
  String? city;
  String? address;
  int? price;
  Location? location;
  DefaultSchedule? defaultSchedule;

  Clinics({
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
    return 'Clinics(id: $id, name: $name, city:$city, address: $address, price:$price, location: $location, defaultSchedule:$defaultSchedule)';
  }

  factory Clinics.fromMap(Map<String, dynamic> data) => Clinics(
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
  /// Parses the string and returns the resulting Json object as [Clinics].
  factory Clinics.fromJson(String data) {
    return Clinics.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Clinics] to a JSON string.
  String toJson() => json.encode(toMap());

  Clinics copyWith({
    String? id,
    String? name,
    String? city,
    String? address,
    int? price,
    Location? location,
    DefaultSchedule? defaultSchedule,
  }) {
    return Clinics(
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
    if (other is! Clinics) return false;
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
