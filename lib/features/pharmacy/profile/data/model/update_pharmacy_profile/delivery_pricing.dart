import 'dart:convert';

import 'package:collection/collection.dart';

class DeliveryPricing {
  String? city;
  int? price;
  String? id;

  DeliveryPricing({this.city, this.price, this.id});

  @override
  String toString() {
    return 'DeliveryPricing(city: $city, price: $price, id: $id)';
  }

  factory DeliveryPricing.fromMap(Map<String, dynamic> data) {
    return DeliveryPricing(
      city: data['city'] as String?,
      price: data['price'] as int?,
      id: data['_id'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'city': city, 'price': price, '_id': id};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeliveryPricing].
  factory DeliveryPricing.fromJson(String data) {
    return DeliveryPricing.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DeliveryPricing] to a JSON string.
  String toJson() => json.encode(toMap());

  DeliveryPricing copyWith({String? city, int? price, String? id}) {
    return DeliveryPricing(
      city: city ?? this.city,
      price: price ?? this.price,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DeliveryPricing) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => city.hashCode ^ price.hashCode ^ id.hashCode;
}
