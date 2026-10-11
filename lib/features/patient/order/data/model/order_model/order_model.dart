import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class OrderModel {
  bool? success;
  String? message;
  Data? data;

  OrderModel({this.success, this.message, this.data});

  @override
  String toString() {
    return 'OrderModel(success: $success, message: $message, data: $data)';
  }

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
    success: data['success'] as bool?,
    message: data['message'] as String?,
    data: data['data'] == null
        ? null
        : Data.fromMap(data['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'data': data?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderModel].
  factory OrderModel.fromJson(String data) {
    return OrderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderModel] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderModel copyWith({bool? success, String? message, Data? data}) {
    return OrderModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
