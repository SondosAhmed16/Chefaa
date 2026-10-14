import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class LabServicesModel {
  bool? success;
  String? facilityType;
  String? aiInsight;
  Data? data;

  LabServicesModel({
    this.success,
    this.facilityType,
    this.aiInsight,
    this.data,
  });

  @override
  String toString() {
    return 'LabServicesModel(success: $success, facilityType: $facilityType, aiInsight: $aiInsight, data: $data)';
  }

  factory LabServicesModel.fromMap(Map<String, dynamic> data) {
    return LabServicesModel(
      success: data['success'] as bool?,
      facilityType: data['facilityType'] as String?,
      aiInsight: data['aiInsight'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'facilityType': facilityType,
    'aiInsight': aiInsight,
    'data': data?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LabServicesModel].
  factory LabServicesModel.fromJson(String data) {
    return LabServicesModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LabServicesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LabServicesModel copyWith({
    bool? success,
    String? facilityType,
    String? aiInsight,
    Data? data,
  }) {
    return LabServicesModel(
      success: success ?? this.success,
      facilityType: facilityType ?? this.facilityType,
      aiInsight: aiInsight ?? this.aiInsight,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LabServicesModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^
      facilityType.hashCode ^
      aiInsight.hashCode ^
      data.hashCode;
}
