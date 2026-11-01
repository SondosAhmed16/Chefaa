import 'dart:convert';

import 'package:collection/collection.dart';

import 'order.dart';
import 'pagination.dart';
import 'status_counts.dart';

class Data {
  List<Order>? orders;
  StatusCounts? statusCounts;
  Pagination? pagination;

  Data({this.orders, this.statusCounts, this.pagination});

  @override
  String toString() {
    return 'Data(orders: $orders, statusCounts: $statusCounts, pagination: $pagination)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    orders: (data['orders'] as List<dynamic>?)
        ?.map((e) => Order.fromMap(e as Map<String, dynamic>))
        .toList(),
    statusCounts: data['statusCounts'] == null
        ? null
        : StatusCounts.fromMap(data['statusCounts'] as Map<String, dynamic>),
    pagination: data['pagination'] == null
        ? null
        : Pagination.fromMap(data['pagination'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'orders': orders?.map((e) => e.toMap()).toList(),
    'statusCounts': statusCounts?.toMap(),
    'pagination': pagination?.toMap(),
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
    List<Order>? orders,
    StatusCounts? statusCounts,
    Pagination? pagination,
  }) {
    return Data(
      orders: orders ?? this.orders,
      statusCounts: statusCounts ?? this.statusCounts,
      pagination: pagination ?? this.pagination,
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
      orders.hashCode ^ statusCounts.hashCode ^ pagination.hashCode;
}
