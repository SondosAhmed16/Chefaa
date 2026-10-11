import 'dart:convert';

import 'package:collection/collection.dart';

import 'order_contents.dart';
import 'status_timeline.dart';

class Data {
  String? orderNumber;
  String? orderStatus;
  dynamic riderInfo;
  StatusTimeline? statusTimeline;
  OrderContents? orderContents;

  Data({
    this.orderNumber,
    this.orderStatus,
    this.riderInfo,
    this.statusTimeline,
    this.orderContents,
  });

  @override
  String toString() {
    return 'Data(orderNumber: $orderNumber, orderStatus: $orderStatus, riderInfo: $riderInfo, statusTimeline: $statusTimeline, orderContents: $orderContents)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    orderNumber: data['orderNumber'] as String?,
    orderStatus: data['orderStatus'] as String?,
    riderInfo: data['riderInfo'] as dynamic,
    statusTimeline: data['statusTimeline'] == null
        ? null
        : StatusTimeline.fromMap(
            data['statusTimeline'] as Map<String, dynamic>,
          ),
    orderContents: data['orderContents'] == null
        ? null
        : OrderContents.fromMap(data['orderContents'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'orderNumber': orderNumber,
    'orderStatus': orderStatus,
    'riderInfo': riderInfo,
    'statusTimeline': statusTimeline?.toMap(),
    'orderContents': orderContents?.toMap(),
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
    String? orderNumber,
    String? orderStatus,
    dynamic riderInfo,
    StatusTimeline? statusTimeline,
    OrderContents? orderContents,
  }) {
    return Data(
      orderNumber: orderNumber ?? this.orderNumber,
      orderStatus: orderStatus ?? this.orderStatus,
      riderInfo: riderInfo ?? this.riderInfo,
      statusTimeline: statusTimeline ?? this.statusTimeline,
      orderContents: orderContents ?? this.orderContents,
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
      orderNumber.hashCode ^
      orderStatus.hashCode ^
      riderInfo.hashCode ^
      statusTimeline.hashCode ^
      orderContents.hashCode;
}
