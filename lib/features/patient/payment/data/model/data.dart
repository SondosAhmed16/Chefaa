import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  String? orderNumber;
  String? paymentStatus;
  int? totalPaid;

  Data({this.orderNumber, this.paymentStatus, this.totalPaid});

  @override
  String toString() {
    return 'Data(orderNumber: $orderNumber, paymentStatus: $paymentStatus, totalPaid: $totalPaid)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    orderNumber: data['orderNumber'] as String?,
    paymentStatus: data['paymentStatus'] as String?,
    totalPaid: data['totalPaid'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'orderNumber': orderNumber,
    'paymentStatus': paymentStatus,
    'totalPaid': totalPaid,
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

  Data copyWith({String? orderNumber, String? paymentStatus, int? totalPaid}) {
    return Data(
      orderNumber: orderNumber ?? this.orderNumber,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      totalPaid: totalPaid ?? this.totalPaid,
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
      orderNumber.hashCode ^ paymentStatus.hashCode ^ totalPaid.hashCode;
}
