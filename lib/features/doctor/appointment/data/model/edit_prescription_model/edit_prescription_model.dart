import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class EditPrescriptionModel {
  bool? success;
  String? message;
  Data? data;

  EditPrescriptionModel({this.success, this.message, this.data});

  @override
  String toString() {
    return 'EditPrescriptionModel(success: $success, message: $message, data: $data)';
  }

  factory EditPrescriptionModel.fromMap(Map<String, dynamic> data) {
    return EditPrescriptionModel(
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
  /// Parses the string and returns the resulting Json object as [EditPrescriptionModel].
  factory EditPrescriptionModel.fromJson(String data) {
    return EditPrescriptionModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [EditPrescriptionModel] to a JSON string.
  String toJson() => json.encode(toMap());

  EditPrescriptionModel copyWith({bool? success, String? message, Data? data}) {
    return EditPrescriptionModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! EditPrescriptionModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
