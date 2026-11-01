import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class OrderStatModel {
  bool? success;
  String? message;
  Data? data;

  OrderStatModel({this.success, this.message, this.data});

  @override
  String toString() {
    return 'OrderStatModel(success: $success, message: $message, data: $data)';
  }

  factory OrderStatModel.fromMap(Map<String, dynamic> data) {
    return OrderStatModel(
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
  /// Parses the string and returns the resulting Json object as [OrderStatModel].
  factory OrderStatModel.fromJson(String data) {
    return OrderStatModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderStatModel] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderStatModel copyWith({bool? success, String? message, Data? data}) {
    return OrderStatModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderStatModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
