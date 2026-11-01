import 'dart:convert';
import 'package:collection/collection.dart';

class StatusCounts {
  int? newOrders;
  int? ready;
  int? preparing;
  int? completed;

  StatusCounts({this.newOrders, this.ready, this.preparing, this.completed});

  @override
  String toString() {
    return 'StatusCounts(newOrders: $newOrders, ready: $ready, preparing: $preparing, completed: $completed)';
  }

  factory StatusCounts.fromMap(Map<String, dynamic> data) => StatusCounts(
    newOrders: data['New'] as int?,
    ready: data['Ready'] as int?,
    preparing: data['Preparing'] as int?,
    completed: data['Completed'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'New': newOrders,
    'Ready': ready,
    'Preparing': preparing,
    'Completed': completed,
  };

  factory StatusCounts.fromJson(String data) {
    return StatusCounts.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  StatusCounts copyWith({
    int? newOrders,
    int? ready,
    int? preparing,
    int? completed,
  }) {
    return StatusCounts(
      newOrders: newOrders ?? this.newOrders,
      ready: ready ?? this.ready,
      preparing: preparing ?? this.preparing,
      completed: completed ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! StatusCounts) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      newOrders.hashCode ^
      ready.hashCode ^
      preparing.hashCode ^
      completed.hashCode;
}
