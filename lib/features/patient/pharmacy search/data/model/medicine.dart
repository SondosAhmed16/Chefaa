import 'dart:convert';

import 'package:collection/collection.dart';

class Medicine {
  String? id;
  String? medicineName;
  String? genericName;
  String? category;
  String? dosageForm;
  int? price;
  int? quantity;
  bool? requiresPrescription;

  Medicine({
    this.id,
    this.medicineName,
    this.genericName,
    this.category,
    this.dosageForm,
    this.price,
    this.quantity,
    this.requiresPrescription,
  });

  @override
  String toString() {
    return 'Medicine(id: $id, medicineName: $medicineName, genericName: $genericName, category: $category, dosageForm: $dosageForm, price: $price, quantity: $quantity, requiresPrescription: $requiresPrescription)';
  }

  factory Medicine.fromMap(Map<String, dynamic> data) => Medicine(
    id: data['_id'] as String?,
    medicineName: data['medicineName'] as String?,
    genericName: data['genericName'] as String?,
    category: data['category'] as String?,
    dosageForm: data['dosageForm'] as String?,
    price: data['price'] as int?,
    quantity: data['quantity'] as int?,
    requiresPrescription: data['requiresPrescription'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'medicineName': medicineName,
    'genericName': genericName,
    'category': category,
    'dosageForm': dosageForm,
    'price': price,
    'quantity': quantity,
    'requiresPrescription': requiresPrescription,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Medicine].
  factory Medicine.fromJson(String data) {
    return Medicine.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Medicine] to a JSON string.
  String toJson() => json.encode(toMap());

  Medicine copyWith({
    String? id,
    String? medicineName,
    String? genericName,
    String? category,
    String? dosageForm,
    int? price,
    int? quantity,
    bool? requiresPrescription,
  }) {
    return Medicine(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      genericName: genericName ?? this.genericName,
      category: category ?? this.category,
      dosageForm: dosageForm ?? this.dosageForm,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Medicine) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      medicineName.hashCode ^
      genericName.hashCode ^
      category.hashCode ^
      dosageForm.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      requiresPrescription.hashCode;
}
