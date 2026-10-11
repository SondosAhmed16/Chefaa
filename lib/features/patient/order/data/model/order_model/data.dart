import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  String? orderId;
  String? orderNumber;
  String? orderType;
  String? pharmacyName;
  String? deliveryTime;
  int? itemsCount;
  int? subtotal;
  int? deliveryFee;
  int? totalPrice;
  String? paymentMethod;

  Data({
    this.orderId,
    this.orderNumber,
    this.orderType,
    this.pharmacyName,
    this.deliveryTime,
    this.itemsCount,
    this.subtotal,
    this.deliveryFee,
    this.totalPrice,
    this.paymentMethod,
  });

  @override
  String toString() {
    return 'Data(orderId: $orderId, orderNumber: $orderNumber, orderType: $orderType, pharmacyName: $pharmacyName, deliveryTime: $deliveryTime, itemsCount: $itemsCount, subtotal: $subtotal, deliveryFee: $deliveryFee, totalPrice: $totalPrice, paymentMethod: $paymentMethod)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    orderId: data['orderId'] as String?,
    orderNumber: data['orderNumber'] as String?,
    orderType: data['orderType'] as String?,
    pharmacyName: data['pharmacyName'] as String?,
    deliveryTime: data['deliveryTime'] as String?,
    itemsCount: data['itemsCount'] as int?,
    subtotal: data['subtotal'] as int?,
    deliveryFee: data['deliveryFee'] as int?,
    totalPrice: data['totalPrice'] as int?,
    paymentMethod: data['paymentMethod'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'orderId': orderId,
    'orderNumber': orderNumber,
    'orderType': orderType,
    'pharmacyName': pharmacyName,
    'deliveryTime': deliveryTime,
    'itemsCount': itemsCount,
    'subtotal': subtotal,
    'deliveryFee': deliveryFee,
    'totalPrice': totalPrice,
    'paymentMethod': paymentMethod,
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
    String? orderType,
    String? pharmacyName,
    String? deliveryTime,
    int? itemsCount,
    int? subtotal,
    int? deliveryFee,
    int? totalPrice,
    String? paymentMethod,
  }) {
    return Data(
      orderId: orderId ?? this.orderId,
      orderNumber: orderNumber ?? this.orderNumber,
      orderType: orderType ?? this.orderType,
      pharmacyName: pharmacyName ?? this.pharmacyName,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      itemsCount: itemsCount ?? this.itemsCount,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
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
      orderType.hashCode ^
      pharmacyName.hashCode ^
      deliveryTime.hashCode ^
      itemsCount.hashCode ^
      subtotal.hashCode ^
      deliveryFee.hashCode ^
      totalPrice.hashCode ^
      paymentMethod.hashCode;
}
