import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class PaymentModel {
  bool? success;
  String? message;
  Data? data;

  PaymentModel({this.success, this.message, this.data});

  @override
  String toString() {
    return 'PaymentModel(success: $success, message: $message, data: $data)';
  }

  factory PaymentModel.fromMap(Map<String, dynamic> data) => PaymentModel(
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
  /// Parses the string and returns the resulting Json object as [PaymentModel].
  factory PaymentModel.fromJson(String data) {
    return PaymentModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PaymentModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PaymentModel copyWith({bool? success, String? message, Data? data}) {
    return PaymentModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PaymentModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
