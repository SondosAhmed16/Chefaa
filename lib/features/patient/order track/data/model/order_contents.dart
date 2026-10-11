import 'dart:convert';

import 'package:collection/collection.dart';

import 'item.dart';
import 'summary.dart';

class OrderContents {
  List<Item>? items;
  Summary? summary;

  OrderContents({this.items, this.summary});

  @override
  String toString() => 'OrderContents(items: $items, summary: $summary)';

  factory OrderContents.fromMap(Map<String, dynamic> data) => OrderContents(
    items: (data['items'] as List<dynamic>?)
        ?.map((e) => Item.fromMap(e as Map<String, dynamic>))
        .toList(),
    summary: data['summary'] == null
        ? null
        : Summary.fromMap(data['summary'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'items': items?.map((e) => e.toMap()).toList(),
    'summary': summary?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderContents].
  factory OrderContents.fromJson(String data) {
    return OrderContents.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderContents] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderContents copyWith({List<Item>? items, Summary? summary}) {
    return OrderContents(
      items: items ?? this.items,
      summary: summary ?? this.summary,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderContents) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => items.hashCode ^ summary.hashCode;
}
