import 'dart:convert';

import 'package:collection/collection.dart';

class Financials {
  int? totalRevenue;
  int? totalCommission;
  int? totalNetEarnings;
  int? currentDue;
  int? lastPaidAmount;
  dynamic lastPaidAt;
  String? paymentStatus;
  dynamic overdueAt;

  Financials({
    this.totalRevenue,
    this.totalCommission,
    this.totalNetEarnings,
    this.currentDue,
    this.lastPaidAmount,
    this.lastPaidAt,
    this.paymentStatus,
    this.overdueAt,
  });

  @override
  String toString() {
    return 'Financials(totalRevenue: $totalRevenue, totalCommission: $totalCommission, totalNetEarnings: $totalNetEarnings, currentDue: $currentDue, lastPaidAmount: $lastPaidAmount, lastPaidAt: $lastPaidAt, paymentStatus: $paymentStatus, overdueAt: $overdueAt)';
  }

  factory Financials.fromMap(Map<String, dynamic> data) => Financials(
    totalRevenue: data['totalRevenue'] as int?,
    totalCommission: data['totalCommission'] as int?,
    totalNetEarnings: data['totalNetEarnings'] as int?,
    currentDue: data['currentDue'] as int?,
    lastPaidAmount: data['lastPaidAmount'] as int?,
    lastPaidAt: data['lastPaidAt'] as dynamic,
    paymentStatus: data['paymentStatus'] as String?,
    overdueAt: data['overdueAt'] as dynamic,
  );

  Map<String, dynamic> toMap() => {
    'totalRevenue': totalRevenue,
    'totalCommission': totalCommission,
    'totalNetEarnings': totalNetEarnings,
    'currentDue': currentDue,
    'lastPaidAmount': lastPaidAmount,
    'lastPaidAt': lastPaidAt,
    'paymentStatus': paymentStatus,
    'overdueAt': overdueAt,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Financials].
  factory Financials.fromJson(String data) {
    return Financials.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Financials] to a JSON string.
  String toJson() => json.encode(toMap());

  Financials copyWith({
    int? totalRevenue,
    int? totalCommission,
    int? totalNetEarnings,
    int? currentDue,
    int? lastPaidAmount,
    dynamic lastPaidAt,
    String? paymentStatus,
    dynamic overdueAt,
  }) {
    return Financials(
      totalRevenue: totalRevenue ?? this.totalRevenue,
      totalCommission: totalCommission ?? this.totalCommission,
      totalNetEarnings: totalNetEarnings ?? this.totalNetEarnings,
      currentDue: currentDue ?? this.currentDue,
      lastPaidAmount: lastPaidAmount ?? this.lastPaidAmount,
      lastPaidAt: lastPaidAt ?? this.lastPaidAt,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      overdueAt: overdueAt ?? this.overdueAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Financials) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      totalRevenue.hashCode ^
      totalCommission.hashCode ^
      totalNetEarnings.hashCode ^
      currentDue.hashCode ^
      lastPaidAmount.hashCode ^
      lastPaidAt.hashCode ^
      paymentStatus.hashCode ^
      overdueAt.hashCode;
}
