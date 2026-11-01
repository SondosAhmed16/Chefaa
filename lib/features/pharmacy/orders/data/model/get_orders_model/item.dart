import 'dart:convert';

import 'package:collection/collection.dart';

import 'medicine_id.dart';

class Item {
  MedicineId? medicineId;
  int? quantity;
  int? price;
  String? id;

  Item({this.medicineId, this.quantity, this.price, this.id});

  @override
  String toString() {
    return 'Item(medicineId: $medicineId, quantity: $quantity, price: $price, id: $id)';
  }

  factory Item.fromMap(Map<String, dynamic> data) => Item(
    medicineId: data['medicineId'] == null
        ? null
        : MedicineId.fromMap(data['medicineId'] as Map<String, dynamic>),
    quantity: data['quantity'] as int?,
    price: data['price'] as int?,
    id: data['_id'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'medicineId': medicineId?.toMap(),
    'quantity': quantity,
    'price': price,
    '_id': id,
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
    MedicineId? medicineId,
    int? quantity,
    int? price,
    String? id,
  }) {
    return Item(
      medicineId: medicineId ?? this.medicineId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      id: id ?? this.id,
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
      medicineId.hashCode ^ quantity.hashCode ^ price.hashCode ^ id.hashCode;
}
