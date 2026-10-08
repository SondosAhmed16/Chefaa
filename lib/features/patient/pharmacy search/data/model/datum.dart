import 'dart:convert';

import 'package:collection/collection.dart';

import 'address.dart';

class Datum {
  String? id;
  num? rating;
  String? deliveryTime;
  List<Address>? addresses;
  String? phone;
  String? pharmacyName;
  double? distanceKm;
  int? availableMedicinesCount;

  Datum({
    this.id,
    this.rating,
    this.deliveryTime,
    this.addresses,
    this.phone,
    this.pharmacyName,
    this.distanceKm,
    this.availableMedicinesCount,
  });

  @override
  String toString() {
    return 'Datum(id: $id, rating: $rating, deliveryTime: $deliveryTime, addresses: $addresses, phone: $phone, pharmacyName: $pharmacyName, distanceKm: $distanceKm, availableMedicinesCount: $availableMedicinesCount)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
    id: data['_id'] as String?,
    rating: data['rating'] as num?,
    deliveryTime: data['deliveryTime'] as String?,
    addresses: (data['addresses'] as List<dynamic>?)
        ?.map((e) => Address.fromMap(e as Map<String, dynamic>))
        .toList(),
    phone: data['phone'] as String?,
    pharmacyName: data['pharmacyName'] as String?,
    distanceKm: (data['distanceKm'] as num?)?.toDouble(),
    availableMedicinesCount: data['availableMedicinesCount'] as int?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'rating': rating,
    'deliveryTime': deliveryTime,
    'addresses': addresses?.map((e) => e.toMap()).toList(),
    'phone': phone,
    'pharmacyName': pharmacyName,
    'distanceKm': distanceKm,
    'availableMedicinesCount': availableMedicinesCount,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    String? id,
    int? rating,
    String? deliveryTime,
    List<Address>? addresses,
    String? phone,
    String? pharmacyName,
    double? distanceKm,
    int? availableMedicinesCount,
  }) {
    return Datum(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      addresses: addresses ?? this.addresses,
      phone: phone ?? this.phone,
      pharmacyName: pharmacyName ?? this.pharmacyName,
      distanceKm: distanceKm ?? this.distanceKm,
      availableMedicinesCount:
          availableMedicinesCount ?? this.availableMedicinesCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Datum) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      rating.hashCode ^
      deliveryTime.hashCode ^
      addresses.hashCode ^
      phone.hashCode ^
      pharmacyName.hashCode ^
      distanceKm.hashCode ^
      availableMedicinesCount.hashCode;
}
