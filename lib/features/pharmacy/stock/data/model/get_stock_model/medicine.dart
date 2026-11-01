import 'dart:convert';

import 'package:collection/collection.dart';

class Medicine {
  String? id;
  String? pharmacyId;
  String? medicineName;
  String? genericName;
  String? concentration;
  String? category;
  String? dosageForm;
  String? manufacturer;
  String? barcode;
  int? price;
  int? quantity;
  int? minThreshold;
  bool? inStock;
  bool? requiresPrescription;
  DateTime? expiryDate;
  String? indications;
  String? sideEffects;
  String? dosageInstructions;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Medicine({
    this.id,
    this.pharmacyId,
    this.medicineName,
    this.genericName,
    this.concentration,
    this.category,
    this.dosageForm,
    this.manufacturer,
    this.barcode,
    this.price,
    this.quantity,
    this.minThreshold,
    this.inStock,
    this.requiresPrescription,
    this.expiryDate,
    this.indications,
    this.sideEffects,
    this.dosageInstructions,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Medicine(id: $id, pharmacyId: $pharmacyId, medicineName: $medicineName, genericName: $genericName, concentration: $concentration, category: $category, dosageForm: $dosageForm, manufacturer: $manufacturer, barcode: $barcode, price: $price, quantity: $quantity, minThreshold: $minThreshold, inStock: $inStock, requiresPrescription: $requiresPrescription, expiryDate: $expiryDate, indications: $indications, sideEffects: $sideEffects, dosageInstructions: $dosageInstructions, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Medicine.fromMap(Map<String, dynamic> data) => Medicine(
    id: data['_id'] as String?,
    pharmacyId: data['pharmacyId'] as String?,
    medicineName: data['medicineName'] as String?,
    genericName: data['genericName'] as String?,
    concentration: data['concentration'] as String?,
    category: data['category'] as String?,
    dosageForm: data['dosageForm'] as String?,
    manufacturer: data['manufacturer'] as String?,
    barcode: data['barcode'] as String?,
    price: data['price'] as int?,
    quantity: data['quantity'] as int?,
    minThreshold: data['minThreshold'] as int?,
    inStock: data['inStock'] as bool?,
    requiresPrescription: data['requiresPrescription'] as bool?,
    expiryDate: data['expiryDate'] == null
        ? null
        : DateTime.parse(data['expiryDate'] as String),
    indications: data['indications'] as String?,
    sideEffects: data['sideEffects'] as String?,
    dosageInstructions: data['dosageInstructions'] as String?,
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
    updatedAt: data['updatedAt'] == null
        ? null
        : DateTime.parse(data['updatedAt'] as String),
    v: data['__v'] as int?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'pharmacyId': pharmacyId,
    'medicineName': medicineName,
    'genericName': genericName,
    'concentration': concentration,
    'category': category,
    'dosageForm': dosageForm,
    'manufacturer': manufacturer,
    'barcode': barcode,
    'price': price,
    'quantity': quantity,
    'minThreshold': minThreshold,
    'inStock': inStock,
    'requiresPrescription': requiresPrescription,
    'expiryDate': expiryDate?.toIso8601String(),
    'indications': indications,
    'sideEffects': sideEffects,
    'dosageInstructions': dosageInstructions,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
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
    String? pharmacyId,
    String? medicineName,
    String? genericName,
    String? concentration,
    String? category,
    String? dosageForm,
    String? manufacturer,
    String? barcode,
    int? price,
    int? quantity,
    int? minThreshold,
    bool? inStock,
    bool? requiresPrescription,
    DateTime? expiryDate,
    String? indications,
    String? sideEffects,
    String? dosageInstructions,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Medicine(
      id: id ?? this.id,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      medicineName: medicineName ?? this.medicineName,
      genericName: genericName ?? this.genericName,
      concentration: concentration ?? this.concentration,
      category: category ?? this.category,
      dosageForm: dosageForm ?? this.dosageForm,
      manufacturer: manufacturer ?? this.manufacturer,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      minThreshold: minThreshold ?? this.minThreshold,
      inStock: inStock ?? this.inStock,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
      expiryDate: expiryDate ?? this.expiryDate,
      indications: indications ?? this.indications,
      sideEffects: sideEffects ?? this.sideEffects,
      dosageInstructions: dosageInstructions ?? this.dosageInstructions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
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
      pharmacyId.hashCode ^
      medicineName.hashCode ^
      genericName.hashCode ^
      concentration.hashCode ^
      category.hashCode ^
      dosageForm.hashCode ^
      manufacturer.hashCode ^
      barcode.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      minThreshold.hashCode ^
      inStock.hashCode ^
      requiresPrescription.hashCode ^
      expiryDate.hashCode ^
      indications.hashCode ^
      sideEffects.hashCode ^
      dosageInstructions.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
