import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class PharmacyMedicienesModel {
  bool? success;
  Data? data;

  PharmacyMedicienesModel({this.success, this.data});

  @override
  String toString() {
    return 'PharmacyMedicienesModel(success: $success, data: $data)';
  }

  factory PharmacyMedicienesModel.fromMap(Map<String, dynamic> data) {
    return PharmacyMedicienesModel(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PharmacyMedicienesModel].
  factory PharmacyMedicienesModel.fromJson(String data) {
    return PharmacyMedicienesModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [PharmacyMedicienesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PharmacyMedicienesModel copyWith({bool? success, Data? data}) {
    return PharmacyMedicienesModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PharmacyMedicienesModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
