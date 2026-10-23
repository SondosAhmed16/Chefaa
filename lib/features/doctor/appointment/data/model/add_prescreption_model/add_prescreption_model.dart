import 'dart:convert';

import 'package:collection/collection.dart';

import '../edit_prescription_model/data.dart';

class AddPrescreptionModel {
  bool? success;
  String? message;
  Data? data;

  AddPrescreptionModel({this.success, this.message, this.data});

  @override
  String toString() {
    return 'AddPrescreptionModel(success: $success, message: $message, data: $data)';
  }

  factory AddPrescreptionModel.fromMap(Map<String, dynamic> data) {
    return AddPrescreptionModel(
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
  /// Parses the string and returns the resulting Json object as [AddPrescreptionModel].
  factory AddPrescreptionModel.fromJson(String data) {
    return AddPrescreptionModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [AddPrescreptionModel] to a JSON string.
  String toJson() => json.encode(toMap());

  AddPrescreptionModel copyWith({bool? success, String? message, Data? data}) {
    return AddPrescreptionModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AddPrescreptionModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
