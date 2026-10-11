import 'dart:convert';

import 'package:collection/collection.dart';

class Summary {
  int? subtotal;
  int? deliveryFee;
  int? discount;
  int? totalPrice;
  String? paymentMethod;

  Summary({
    this.subtotal,
    this.deliveryFee,
    this.discount,
    this.totalPrice,
    this.paymentMethod,
  });

  @override
  String toString() {
    return 'Summary(subtotal: $subtotal, deliveryFee: $deliveryFee, discount: $discount, totalPrice: $totalPrice, paymentMethod: $paymentMethod)';
  }

  factory Summary.fromMap(Map<String, dynamic> data) => Summary(
    subtotal: data['subtotal'] as int?,
    deliveryFee: data['deliveryFee'] as int?,
    discount: data['discount'] as int?,
    totalPrice: data['totalPrice'] as int?,
    paymentMethod: data['paymentMethod'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'subtotal': subtotal,
    'deliveryFee': deliveryFee,
    'discount': discount,
    'totalPrice': totalPrice,
    'paymentMethod': paymentMethod,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Summary].
  factory Summary.fromJson(String data) {
    return Summary.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Summary] to a JSON string.
  String toJson() => json.encode(toMap());

  Summary copyWith({
    int? subtotal,
    int? deliveryFee,
    int? discount,
    int? totalPrice,
    String? paymentMethod,
  }) {
    return Summary(
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Summary) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      subtotal.hashCode ^
      deliveryFee.hashCode ^
      discount.hashCode ^
      totalPrice.hashCode ^
      paymentMethod.hashCode;
}
