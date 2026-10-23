import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';
import 'transaction_info.dart';

class PaiedAppointmentModel {
  bool? success;
  String? message;
  Data? data;
  TransactionInfo? transactionInfo;

  PaiedAppointmentModel({
    this.success,
    this.message,
    this.data,
    this.transactionInfo,
  });

  @override
  String toString() {
    return 'PaiedAppointmentModel(success: $success, message: $message, data: $data, transactionInfo: $transactionInfo)';
  }

  factory PaiedAppointmentModel.fromMap(Map<String, dynamic> data) {
    return PaiedAppointmentModel(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
      transactionInfo: data['transactionInfo'] == null
          ? null
          : TransactionInfo.fromMap(
              data['transactionInfo'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'data': data?.toMap(),
    'transactionInfo': transactionInfo?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PaiedAppointmentModel].
  factory PaiedAppointmentModel.fromJson(String data) {
    return PaiedAppointmentModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [PaiedAppointmentModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PaiedAppointmentModel copyWith({
    bool? success,
    String? message,
    Data? data,
    TransactionInfo? transactionInfo,
  }) {
    return PaiedAppointmentModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      transactionInfo: transactionInfo ?? this.transactionInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PaiedAppointmentModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^
      message.hashCode ^
      data.hashCode ^
      transactionInfo.hashCode;
}
