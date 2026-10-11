import 'dart:convert';

import 'package:collection/collection.dart';

class VerifiedItem {
  String? medicineId;
  int? quantity;
  int? price;
  String? itemStatus;

  VerifiedItem({this.medicineId, this.quantity, this.price, this.itemStatus});

  @override
  String toString() {
    return 'VerifiedItem(medicineId: $medicineId, quantity: $quantity, price: $price, itemStatus: $itemStatus)';
  }

  factory VerifiedItem.fromMap(Map<String, dynamic> data) => VerifiedItem(
    medicineId: data['medicineId'] as String?,
    quantity: data['quantity'] as int?,
    price: data['price'] as int?,
    itemStatus: data['itemStatus'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'medicineId': medicineId,
    'quantity': quantity,
    'price': price,
    'itemStatus': itemStatus,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VerifiedItem].
  factory VerifiedItem.fromJson(String data) {
    return VerifiedItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VerifiedItem] to a JSON string.
  String toJson() => json.encode(toMap());

  VerifiedItem copyWith({
    String? medicineId,
    int? quantity,
    int? price,
    String? itemStatus,
  }) {
    return VerifiedItem(
      medicineId: medicineId ?? this.medicineId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      itemStatus: itemStatus ?? this.itemStatus,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! VerifiedItem) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      medicineId.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      itemStatus.hashCode;
}
