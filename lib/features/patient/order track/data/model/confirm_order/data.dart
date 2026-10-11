import 'dart:convert';

import 'package:collection/collection.dart';

import 'verified_item.dart';

class Data {
  String? orderId;
  String? orderNumber;
  String? status;
  String? paymentStatus;
  int? totalPrice;
  double? commission;
  double? pharmacyEarns;
  String? transactionId;
  List<VerifiedItem>? verifiedItems;

  Data({
    this.orderId,
    this.orderNumber,
    this.status,
    this.paymentStatus,
    this.totalPrice,
    this.commission,
    this.pharmacyEarns,
    this.transactionId,
    this.verifiedItems,
  });

  @override
  String toString() {
    return 'Data(orderId: $orderId, orderNumber: $orderNumber, status: $status, paymentStatus: $paymentStatus, totalPrice: $totalPrice, commission: $commission, pharmacyEarns: $pharmacyEarns, transactionId: $transactionId, verifiedItems: $verifiedItems)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    orderId: data['orderId'] as String?,
    orderNumber: data['orderNumber'] as String?,
    status: data['status'] as String?,
    paymentStatus: data['paymentStatus'] as String?,
    totalPrice: data['totalPrice'] as int?,
    commission: (data['commission'] as num?)?.toDouble(),
    pharmacyEarns: (data['pharmacyEarns'] as num?)?.toDouble(),
    transactionId: data['transactionId'] as String?,
    verifiedItems: (data['verifiedItems'] as List<dynamic>?)
        ?.map((e) => VerifiedItem.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'orderId': orderId,
    'orderNumber': orderNumber,
    'status': status,
    'paymentStatus': paymentStatus,
    'totalPrice': totalPrice,
    'commission': commission,
    'pharmacyEarns': pharmacyEarns,
    'transactionId': transactionId,
    'verifiedItems': verifiedItems?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    String? orderId,
    String? orderNumber,
    String? status,
    String? paymentStatus,
    int? totalPrice,
    double? commission,
    double? pharmacyEarns,
    String? transactionId,
    List<VerifiedItem>? verifiedItems,
  }) {
    return Data(
      orderId: orderId ?? this.orderId,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      totalPrice: totalPrice ?? this.totalPrice,
      commission: commission ?? this.commission,
      pharmacyEarns: pharmacyEarns ?? this.pharmacyEarns,
      transactionId: transactionId ?? this.transactionId,
      verifiedItems: verifiedItems ?? this.verifiedItems,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      orderId.hashCode ^
      orderNumber.hashCode ^
      status.hashCode ^
      paymentStatus.hashCode ^
      totalPrice.hashCode ^
      commission.hashCode ^
      pharmacyEarns.hashCode ^
      transactionId.hashCode ^
      verifiedItems.hashCode;
}
