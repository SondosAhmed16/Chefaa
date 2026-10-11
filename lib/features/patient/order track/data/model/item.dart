import 'dart:convert';

import 'package:collection/collection.dart';

class Item {
  String? medicineId;
  String? medicineName;
  int? quantity;
  int? price;
  int? itemTotal;

  Item({
    this.medicineId,
    this.medicineName,
    this.quantity,
    this.price,
    this.itemTotal,
  });

  @override
  String toString() {
    return 'Item(medicineId: $medicineId, medicineName: $medicineName, quantity: $quantity, price: $price, itemTotal: $itemTotal)';
  }

  factory Item.fromMap(Map<String, dynamic> data) => Item(
    medicineId: data['medicineId'] as String?,
    medicineName: data['medicineName'] as String?,
    quantity: data['quantity'] as int?,
    price: data['price'] as int?,
    itemTotal: data['itemTotal'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'medicineId': medicineId,
    'medicineName': medicineName,
    'quantity': quantity,
    'price': price,
    'itemTotal': itemTotal,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Item].
  factory Item.fromJson(String data) {
    return Item.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Item] to a JSON string.
  String toJson() => json.encode(toMap());

  Item copyWith({
    String? medicineId,
    String? medicineName,
    int? quantity,
    int? price,
    int? itemTotal,
  }) {
    return Item(
      medicineId: medicineId ?? this.medicineId,
      medicineName: medicineName ?? this.medicineName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      itemTotal: itemTotal ?? this.itemTotal,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Item) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      medicineId.hashCode ^
      medicineName.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      itemTotal.hashCode;
}
