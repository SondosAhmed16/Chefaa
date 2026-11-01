import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class AddMedicineModel {
  bool? success;
  String? message;
  Data? data;

  AddMedicineModel({this.success, this.message, this.data});

  @override
  String toString() {
    return 'AddMedicineModel(success: $success, message: $message, data: $data)';
  }

  factory AddMedicineModel.fromMap(Map<String, dynamic> data) {
    return AddMedicineModel(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'data': data?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddMedicineModel].
  factory AddMedicineModel.fromJson(String data) {
    return AddMedicineModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddMedicineModel] to a JSON string.
  String toJson() => json.encode(toMap());

  AddMedicineModel copyWith({bool? success, String? message, Data? data}) {
    return AddMedicineModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AddMedicineModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
