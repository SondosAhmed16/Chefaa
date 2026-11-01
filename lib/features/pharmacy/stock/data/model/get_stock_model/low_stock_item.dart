import 'dart:convert';

import 'package:collection/collection.dart';

class LowStockItem {
  String? id;
  String? medicineName;
  String? category;
  int? price;
  int? quantity;
  int? minThreshold;
  bool? inStock;

  LowStockItem({
    this.id,
    this.medicineName,
    this.category,
    this.price,
    this.quantity,
    this.minThreshold,
    this.inStock,
  });

  @override
  String toString() {
    return 'LowStockItem(id: $id, medicineName: $medicineName, category: $category, price: $price, quantity: $quantity, minThreshold: $minThreshold, inStock: $inStock)';
  }

  factory LowStockItem.fromMap(Map<String, dynamic> data) => LowStockItem(
    id: data['_id'] as String?,
    medicineName: data['medicineName'] as String?,
    category: data['category'] as String?,
    price: data['price'] as int?,
    quantity: data['quantity'] as int?,
    minThreshold: data['minThreshold'] as int?,
    inStock: data['inStock'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'medicineName': medicineName,
    'category': category,
    'price': price,
    'quantity': quantity,
    'minThreshold': minThreshold,
    'inStock': inStock,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LowStockItem].
  factory LowStockItem.fromJson(String data) {
    return LowStockItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LowStockItem] to a JSON string.
  String toJson() => json.encode(toMap());

  LowStockItem copyWith({
    String? id,
    String? medicineName,
    String? category,
    int? price,
    int? quantity,
    int? minThreshold,
    bool? inStock,
  }) {
    return LowStockItem(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      minThreshold: minThreshold ?? this.minThreshold,
      inStock: inStock ?? this.inStock,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LowStockItem) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      medicineName.hashCode ^
      category.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      minThreshold.hashCode ^
      inStock.hashCode;
}
