import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class ConfirmOrder {
  bool? success;
  String? message;
  Data? data;

  ConfirmOrder({this.success, this.message, this.data});

  @override
  String toString() {
    return 'ConfirmOrder(success: $success, message: $message, data: $data)';
  }

  factory ConfirmOrder.fromMap(Map<String, dynamic> data) => ConfirmOrder(
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
  /// Parses the string and returns the resulting Json object as [ConfirmOrder].
  factory ConfirmOrder.fromJson(String data) {
    return ConfirmOrder.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ConfirmOrder] to a JSON string.
  String toJson() => json.encode(toMap());

  ConfirmOrder copyWith({bool? success, String? message, Data? data}) {
    return ConfirmOrder(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ConfirmOrder) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
