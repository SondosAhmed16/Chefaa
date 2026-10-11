import 'dart:convert';

import 'package:collection/collection.dart';

class Datum {
  String? orderId;
  String? orderNumber;
  String? pharmacyName;
  String? orderType;
  int? totalPrice;
  String? paymentStatus;
  bool? isPatientConfirmed;
  DateTime? confirmedAt;
  DateTime? createdAt;

  Datum({
    this.orderId,
    this.orderNumber,
    this.pharmacyName,
    this.orderType,
    this.totalPrice,
    this.paymentStatus,
    this.isPatientConfirmed,
    this.confirmedAt,
    this.createdAt,
  });

  @override
  String toString() {
    return 'Datum(orderId: $orderId, orderNumber: $orderNumber, pharmacyName: $pharmacyName, orderType: $orderType, totalPrice: $totalPrice, paymentStatus: $paymentStatus, isPatientConfirmed: $isPatientConfirmed, confirmedAt: $confirmedAt, createdAt: $createdAt)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
    orderId: data['orderId'] as String?,
    orderNumber: data['orderNumber'] as String?,
    pharmacyName: data['pharmacyName'] as String?,
    orderType: data['orderType'] as String?,
    totalPrice: data['totalPrice'] as int?,
    paymentStatus: data['paymentStatus'] as String?,
    isPatientConfirmed: data['isPatientConfirmed'] as bool?,
    confirmedAt: data['confirmedAt'] == null
        ? null
        : DateTime.parse(data['confirmedAt'] as String),
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
  );

  Map<String, dynamic> toMap() => {
    'orderId': orderId,
    'orderNumber': orderNumber,
    'pharmacyName': pharmacyName,
    'orderType': orderType,
    'totalPrice': totalPrice,
    'paymentStatus': paymentStatus,
    'isPatientConfirmed': isPatientConfirmed,
    'confirmedAt': confirmedAt?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    String? orderId,
    String? orderNumber,
    String? pharmacyName,
    String? orderType,
    int? totalPrice,
    String? paymentStatus,
    bool? isPatientConfirmed,
    DateTime? confirmedAt,
    DateTime? createdAt,
  }) {
    return Datum(
      orderId: orderId ?? this.orderId,
      orderNumber: orderNumber ?? this.orderNumber,
      pharmacyName: pharmacyName ?? this.pharmacyName,
      orderType: orderType ?? this.orderType,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      isPatientConfirmed: isPatientConfirmed ?? this.isPatientConfirmed,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Datum) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      orderId.hashCode ^
      orderNumber.hashCode ^
      pharmacyName.hashCode ^
      orderType.hashCode ^
      totalPrice.hashCode ^
      paymentStatus.hashCode ^
      isPatientConfirmed.hashCode ^
      confirmedAt.hashCode ^
      createdAt.hashCode;
}
