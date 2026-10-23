import 'dart:convert';

import 'package:collection/collection.dart';

class TransactionInfo {
  int? amount;
  double? platformFee;
  String? currency;

  TransactionInfo({this.amount, this.platformFee, this.currency});

  @override
  String toString() {
    return 'TransactionInfo(amount: $amount, platformFee: $platformFee, currency: $currency)';
  }

  factory TransactionInfo.fromMap(Map<String, dynamic> data) {
    return TransactionInfo(
      amount: data['amount'] as int?,
      platformFee: (data['platformFee'] as num?)?.toDouble(),
      currency: data['currency'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'amount': amount,
    'platformFee': platformFee,
    'currency': currency,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TransactionInfo].
  factory TransactionInfo.fromJson(String data) {
    return TransactionInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TransactionInfo] to a JSON string.
  String toJson() => json.encode(toMap());

  TransactionInfo copyWith({
    int? amount,
    double? platformFee,
    String? currency,
  }) {
    return TransactionInfo(
      amount: amount ?? this.amount,
      platformFee: platformFee ?? this.platformFee,
      currency: currency ?? this.currency,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TransactionInfo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      amount.hashCode ^ platformFee.hashCode ^ currency.hashCode;
}
