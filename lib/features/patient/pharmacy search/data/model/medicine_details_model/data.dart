import 'dart:convert';

import 'package:collection/collection.dart';

import 'medicine_info.dart';
import 'usage_instructions.dart';

class Data {
  String? id;
  String? medicineName;
  String? category;
  int? price;
  bool? requiresPrescription;
  bool? inStock;
  int? availableQuantity;
  MedicineInfo? medicineInfo;
  UsageInstructions? usageInstructions;
  String? pharmacyName;

  Data({
    this.id,
    this.medicineName,
    this.category,
    this.price,
    this.requiresPrescription,
    this.inStock,
    this.availableQuantity,
    this.medicineInfo,
    this.usageInstructions,
    this.pharmacyName,
  });

  @override
  String toString() {
    return 'Data(id: $id, medicineName: $medicineName, category: $category, price: $price, requiresPrescription: $requiresPrescription, inStock: $inStock, availableQuantity: $availableQuantity, medicineInfo: $medicineInfo, usageInstructions: $usageInstructions, pharmacyName: $pharmacyName)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    id: data['_id'] as String?,
    medicineName: data['medicineName'] as String?,
    category: data['category'] as String?,
    price: data['price'] as int?,
    requiresPrescription: data['requiresPrescription'] as bool?,
    inStock: data['inStock'] as bool?,
    availableQuantity: data['availableQuantity'] as int?,
    medicineInfo: data['medicineInfo'] == null
        ? null
        : MedicineInfo.fromMap(data['medicineInfo'] as Map<String, dynamic>),
    usageInstructions: data['usageInstructions'] == null
        ? null
        : UsageInstructions.fromMap(
            data['usageInstructions'] as Map<String, dynamic>,
          ),
    pharmacyName: data['pharmacyName'] as String?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'medicineName': medicineName,
    'category': category,
    'price': price,
    'requiresPrescription': requiresPrescription,
    'inStock': inStock,
    'availableQuantity': availableQuantity,
    'medicineInfo': medicineInfo?.toMap(),
    'usageInstructions': usageInstructions?.toMap(),
    'pharmacyName': pharmacyName,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    String? id,
    String? medicineName,
    String? category,
    int? price,
    bool? requiresPrescription,
    bool? inStock,
    int? availableQuantity,
    MedicineInfo? medicineInfo,
    UsageInstructions? usageInstructions,
    String? pharmacyName,
  }) {
    return Data(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      category: category ?? this.category,
      price: price ?? this.price,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
      inStock: inStock ?? this.inStock,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      medicineInfo: medicineInfo ?? this.medicineInfo,
      usageInstructions: usageInstructions ?? this.usageInstructions,
      pharmacyName: pharmacyName ?? this.pharmacyName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      medicineName.hashCode ^
      category.hashCode ^
      price.hashCode ^
      requiresPrescription.hashCode ^
      inStock.hashCode ^
      availableQuantity.hashCode ^
      medicineInfo.hashCode ^
      usageInstructions.hashCode ^
      pharmacyName.hashCode;
}
