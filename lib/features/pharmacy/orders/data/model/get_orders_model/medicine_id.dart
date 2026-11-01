import 'dart:convert';

import 'package:collection/collection.dart';

class MedicineId {
  String? id;
  String? medicineName;

  MedicineId({this.id, this.medicineName});

  @override
  String toString() => 'MedicineId(id: $id, medicineName: $medicineName)';

  factory MedicineId.fromMap(Map<String, dynamic> data) => MedicineId(
    id: data['_id'] as String?,
    medicineName: data['medicineName'] as String?,
  );

  Map<String, dynamic> toMap() => {'_id': id, 'medicineName': medicineName};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MedicineId].
  factory MedicineId.fromJson(String data) {
    return MedicineId.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MedicineId] to a JSON string.
  String toJson() => json.encode(toMap());

  MedicineId copyWith({String? id, String? medicineName}) {
    return MedicineId(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MedicineId) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ medicineName.hashCode;
}
