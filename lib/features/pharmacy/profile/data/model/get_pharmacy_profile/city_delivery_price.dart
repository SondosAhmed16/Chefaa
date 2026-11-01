import 'dart:convert';

import 'package:collection/collection.dart';

class CityDeliveryPrice {
  String? city;
  int? price;
  String? id;

  CityDeliveryPrice({this.city, this.price, this.id});

  @override
  String toString() {
    return 'CityDeliveryPrice(city: $city, price: $price, id: $id)';
  }

  factory CityDeliveryPrice.fromMap(Map<String, dynamic> data) {
    return CityDeliveryPrice(
      city: data['city'] as String?,
      price: data['price'] as int?,
      id: data['_id'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'city': city, 'price': price, '_id': id};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CityDeliveryPrice].
  factory CityDeliveryPrice.fromJson(String data) {
    return CityDeliveryPrice.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CityDeliveryPrice] to a JSON string.
  String toJson() => json.encode(toMap());

  CityDeliveryPrice copyWith({String? city, int? price, String? id}) {
    return CityDeliveryPrice(
      city: city ?? this.city,
      price: price ?? this.price,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CityDeliveryPrice) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => city.hashCode ^ price.hashCode ^ id.hashCode;
}
