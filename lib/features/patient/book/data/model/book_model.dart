import 'dart:convert';

import 'package:collection/collection.dart';

import 'appointment.dart';
import 'payment_info.dart';

class BookModel {
  String? message;
  Appointment? appointment;
  PaymentInfo? paymentInfo;

  BookModel({this.message, this.appointment, this.paymentInfo});

  @override
  String toString() {
    return 'BookModel(message: $message, appointment: $appointment, paymentInfo: $paymentInfo)';
  }

  factory BookModel.fromMap(Map<String, dynamic> data) => BookModel(
    message: data['message'] as String?,
    appointment: data['appointment'] == null
        ? null
        : Appointment.fromMap(data['appointment'] as Map<String, dynamic>),
    paymentInfo: data['paymentInfo'] == null
        ? null
        : PaymentInfo.fromMap(data['paymentInfo'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'message': message,
    'appointment': appointment?.toMap(),
    'paymentInfo': paymentInfo?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookModel].
  factory BookModel.fromJson(String data) {
    return BookModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BookModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BookModel copyWith({
    String? message,
    Appointment? appointment,
    PaymentInfo? paymentInfo,
  }) {
    return BookModel(
      message: message ?? this.message,
      appointment: appointment ?? this.appointment,
      paymentInfo: paymentInfo ?? this.paymentInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BookModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      message.hashCode ^ appointment.hashCode ^ paymentInfo.hashCode;
}
