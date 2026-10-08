import 'dart:convert';

import 'package:collection/collection.dart';

class MostOrdered {
  String? id;
  String? medicineName;
  String? category;
  int? price;
  bool? requiresPrescription;
  String? dosageForm;

  MostOrdered({
    this.id,
    this.medicineName,
    this.category,
    this.price,
    this.requiresPrescription,
    this.dosageForm,
  });

  @override
  String toString() {
    return 'MostOrdered(id: $id, medicineName: $medicineName, category: $category, price: $price, requiresPrescription: $requiresPrescription, dosageForm: $dosageForm)';
  }

  factory MostOrdered.fromMap(Map<String, dynamic> data) => MostOrdered(
    id: data['_id'] as String?,
    medicineName: data['medicineName'] as String?,
    category: data['category'] as String?,
    price: data['price'] as int?,
    requiresPrescription: data['requiresPrescription'] as bool?,
    dosageForm: data['dosageForm'] as String?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'medicineName': medicineName,
    'category': category,
    'price': price,
    'requiresPrescription': requiresPrescription,
    'dosageForm': dosageForm,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MostOrdered].
  factory MostOrdered.fromJson(String data) {
    return MostOrdered.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MostOrdered] to a JSON string.
  String toJson() => json.encode(toMap());

  MostOrdered copyWith({
    String? id,
    String? medicineName,
    String? category,
    int? price,
    bool? requiresPrescription,
    String? dosageForm,
  }) {
    return MostOrdered(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      category: category ?? this.category,
      price: price ?? this.price,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
      dosageForm: dosageForm ?? this.dosageForm,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MostOrdered) return false;
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
      dosageForm.hashCode;
}
