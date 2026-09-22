import 'dart:convert';

import 'package:collection/collection.dart';

class Clinic {
  String? id;
  String? name;
  String? address;
  int? price;

  Clinic({this.id, this.name, this.address, this.price});

  @override
  String toString() {
    return 'Clinic(id: $id, name: $name, address: $address, price: $price)';
  }

  factory Clinic.fromMap(Map<String, dynamic> data) => Clinic(
    id: data['_id'] as String?,
    name: data['name'] as String?,
    address: data['address'] as String?,
    price: data['price'] as int?,
  );

  Map<String, dynamic> toMap() => {
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

  Clinic copyWith({String? id, String? name, String? address, int? price}) {
    return Clinic(
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
      id.hashCode ^ name.hashCode ^ address.hashCode ^ price.hashCode;
}
