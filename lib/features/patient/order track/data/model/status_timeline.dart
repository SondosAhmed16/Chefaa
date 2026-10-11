import 'dart:convert';

import 'package:collection/collection.dart';

import 'on_the_way.dart';
import 'order_confirmed.dart';
import 'pharmacy_preparing.dart';
import 'rider_picked_up.dart';

class StatusTimeline {
  OrderConfirmed? orderConfirmed;
  PharmacyPreparing? pharmacyPreparing;
  RiderPickedUp? riderPickedUp;
  OnTheWay? onTheWay;

  StatusTimeline({
    this.orderConfirmed,
    this.pharmacyPreparing,
    this.riderPickedUp,
    this.onTheWay,
  });

  @override
  String toString() {
    return 'StatusTimeline(orderConfirmed: $orderConfirmed, pharmacyPreparing: $pharmacyPreparing, riderPickedUp: $riderPickedUp, onTheWay: $onTheWay)';
  }

  factory StatusTimeline.fromMap(Map<String, dynamic> data) {
    return StatusTimeline(
      orderConfirmed: data['orderConfirmed'] == null
          ? null
          : OrderConfirmed.fromMap(
              data['orderConfirmed'] as Map<String, dynamic>,
            ),
      pharmacyPreparing: data['pharmacyPreparing'] == null
          ? null
          : PharmacyPreparing.fromMap(
              data['pharmacyPreparing'] as Map<String, dynamic>,
            ),
      riderPickedUp: data['riderPickedUp'] == null
          ? null
          : RiderPickedUp.fromMap(
              data['riderPickedUp'] as Map<String, dynamic>,
            ),
      onTheWay: data['onTheWay'] == null
          ? null
          : OnTheWay.fromMap(data['onTheWay'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'orderConfirmed': orderConfirmed?.toMap(),
    'pharmacyPreparing': pharmacyPreparing?.toMap(),
    'riderPickedUp': riderPickedUp?.toMap(),
    'onTheWay': onTheWay?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StatusTimeline].
  factory StatusTimeline.fromJson(String data) {
    return StatusTimeline.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StatusTimeline] to a JSON string.
  String toJson() => json.encode(toMap());

  StatusTimeline copyWith({
    OrderConfirmed? orderConfirmed,
    PharmacyPreparing? pharmacyPreparing,
    RiderPickedUp? riderPickedUp,
    OnTheWay? onTheWay,
  }) {
    return StatusTimeline(
      orderConfirmed: orderConfirmed ?? this.orderConfirmed,
      pharmacyPreparing: pharmacyPreparing ?? this.pharmacyPreparing,
      riderPickedUp: riderPickedUp ?? this.riderPickedUp,
      onTheWay: onTheWay ?? this.onTheWay,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! StatusTimeline) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      orderConfirmed.hashCode ^
      pharmacyPreparing.hashCode ^
      riderPickedUp.hashCode ^
      onTheWay.hashCode;
}
