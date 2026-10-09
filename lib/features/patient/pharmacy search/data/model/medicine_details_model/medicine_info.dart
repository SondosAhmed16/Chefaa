import 'dart:convert';

import 'package:collection/collection.dart';

class MedicineInfo {
  String? brandName;
  String? concentration;
  String? manufacturer;
  String? prescription;
  String? shelf;

  MedicineInfo({
    this.brandName,
    this.concentration,
    this.manufacturer,
    this.prescription,
    this.shelf,
  });

  @override
  String toString() {
    return 'MedicineInfo(brandName: $brandName, concentration: $concentration, manufacturer: $manufacturer, prescription: $prescription, shelf: $shelf)';
  }

  factory MedicineInfo.fromMap(Map<String, dynamic> data) => MedicineInfo(
    brandName: data['brandName'] as String?,
    concentration: data['concentration'] as String?,
    manufacturer: data['manufacturer'] as String?,
    prescription: data['prescription'] as String?,
    shelf: data['shelf'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'brandName': brandName,
    'concentration': concentration,
    'manufacturer': manufacturer,
    'prescription': prescription,
    'shelf': shelf,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MedicineInfo].
  factory MedicineInfo.fromJson(String data) {
    return MedicineInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MedicineInfo] to a JSON string.
  String toJson() => json.encode(toMap());

  MedicineInfo copyWith({
    String? brandName,
    String? concentration,
    String? manufacturer,
    String? prescription,
    String? shelf,
  }) {
    return MedicineInfo(
      brandName: brandName ?? this.brandName,
      concentration: concentration ?? this.concentration,
      manufacturer: manufacturer ?? this.manufacturer,
      prescription: prescription ?? this.prescription,
      shelf: shelf ?? this.shelf,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MedicineInfo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      brandName.hashCode ^
      concentration.hashCode ^
      manufacturer.hashCode ^
      prescription.hashCode ^
      shelf.hashCode;
}
