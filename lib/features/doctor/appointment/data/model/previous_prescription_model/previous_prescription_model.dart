import 'dart:convert';

import 'package:collection/collection.dart';

import '../edit_prescription_model/data.dart';

class PreviousPrescriptionModel {
  bool? success;
  Data? data;

  PreviousPrescriptionModel({this.success, this.data});

  @override
  String toString() {
    return 'PreviousPrescriptionModel(success: $success, data: $data)';
  }

  factory PreviousPrescriptionModel.fromMap(Map<String, dynamic> data) {
    return PreviousPrescriptionModel(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PreviousPrescriptionModel].
  factory PreviousPrescriptionModel.fromJson(String data) {
    return PreviousPrescriptionModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [PreviousPrescriptionModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PreviousPrescriptionModel copyWith({bool? success, Data? data}) {
    return PreviousPrescriptionModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PreviousPrescriptionModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
