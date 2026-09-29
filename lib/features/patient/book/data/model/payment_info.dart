import 'dart:convert';

import 'package:collection/collection.dart';

class PaymentInfo {
  String? status;
  int? amount;
  String? currency;

  PaymentInfo({this.status, this.amount, this.currency});

  @override
  String toString() {
    return 'PaymentInfo(status: $status, amount: $amount, currency: $currency)';
  }

  factory PaymentInfo.fromMap(Map<String, dynamic> data) => PaymentInfo(
    status: data['status'] as String?,
    amount: data['amount'] as int?,
    currency: data['currency'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'status': status,
    'amount': amount,
    'currency': currency,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PaymentInfo].
  factory PaymentInfo.fromJson(String data) {
    return PaymentInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PaymentInfo] to a JSON string.
  String toJson() => json.encode(toMap());

  PaymentInfo copyWith({String? status, int? amount, String? currency}) {
    return PaymentInfo(
      status: status ?? this.status,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PaymentInfo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ amount.hashCode ^ currency.hashCode;
}
