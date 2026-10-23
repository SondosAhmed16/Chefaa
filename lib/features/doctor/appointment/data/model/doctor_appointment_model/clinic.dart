import 'dart:convert';

import 'package:collection/collection.dart';

import 'default_schedule.dart';

class Clinic {
  DefaultSchedule? defaultSchedule;
  String? id;
  String? name;
  String? address;
  int? price;

  Clinic({this.defaultSchedule, this.id, this.name, this.address, this.price});

  @override
  String toString() {
    return 'Clinic(defaultSchedule: $defaultSchedule, id: $id, name: $name, address: $address, price: $price)';
  }

  factory Clinic.fromMap(Map<String, dynamic> data) => Clinic(
    defaultSchedule: data['defaultSchedule'] == null
        ? null
        : DefaultSchedule.fromMap(
            data['defaultSchedule'] as Map<String, dynamic>,
          ),
    id: data['_id'] as String?,
    name: data['name'] as String?,
    address: data['address'] as String?,
    price: data['price'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'defaultSchedule': defaultSchedule?.toMap(),
    '_id': id,
    'name': name,
    'address': address,
    'price': price,
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
    DefaultSchedule? defaultSchedule,
    String? id,
    String? name,
    String? address,
    int? price,
  }) {
    return Clinic(
      defaultSchedule: defaultSchedule ?? this.defaultSchedule,
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      price: price ?? this.price,
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
      defaultSchedule.hashCode ^
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      price.hashCode;
}
