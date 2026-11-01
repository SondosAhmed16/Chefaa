import 'dart:convert';

import 'package:collection/collection.dart';

class Summary {
  int? total;
  int? lowStockCount;
  int? outOfStockCount;

  Summary({this.total, this.lowStockCount, this.outOfStockCount});

  @override
  String toString() {
    return 'Summary(total: $total, lowStockCount: $lowStockCount, outOfStockCount: $outOfStockCount)';
  }

  factory Summary.fromMap(Map<String, dynamic> data) => Summary(
    total: data['total'] as int?,
    lowStockCount: data['lowStockCount'] as int?,
    outOfStockCount: data['outOfStockCount'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'total': total,
    'lowStockCount': lowStockCount,
    'outOfStockCount': outOfStockCount,
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

  Summary copyWith({int? total, int? lowStockCount, int? outOfStockCount}) {
    return Summary(
      total: total ?? this.total,
      lowStockCount: lowStockCount ?? this.lowStockCount,
      outOfStockCount: outOfStockCount ?? this.outOfStockCount,
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
      total.hashCode ^ lowStockCount.hashCode ^ outOfStockCount.hashCode;
}
