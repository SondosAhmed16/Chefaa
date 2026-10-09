import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class MedicineDetailsModel {
  bool? success;
  Data? data;

  MedicineDetailsModel({this.success, this.data});

  @override
  String toString() {
    return 'MedicineDetailsModel(success: $success, data: $data)';
  }

  factory MedicineDetailsModel.fromMap(Map<String, dynamic> data) {
    return MedicineDetailsModel(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MedicineDetailsModel].
  factory MedicineDetailsModel.fromJson(String data) {
    return MedicineDetailsModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [MedicineDetailsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MedicineDetailsModel copyWith({bool? success, Data? data}) {
    return MedicineDetailsModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MedicineDetailsModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
