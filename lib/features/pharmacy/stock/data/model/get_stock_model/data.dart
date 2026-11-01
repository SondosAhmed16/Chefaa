import 'dart:convert';

import 'package:collection/collection.dart';

import 'low_stock_item.dart';
import 'medicine.dart';
import 'pagination.dart';
import 'summary.dart';

class Data {
  List<Medicine>? medicines;
  List<LowStockItem>? lowStockItems;
  Summary? summary;
  Pagination? pagination;

  Data({this.medicines, this.lowStockItems, this.summary, this.pagination});

  @override
  String toString() {
    return 'Data(medicines: $medicines, lowStockItems: $lowStockItems, summary: $summary, pagination: $pagination)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    medicines: (data['medicines'] as List<dynamic>?)
        ?.map((e) => Medicine.fromMap(e as Map<String, dynamic>))
        .toList(),
    lowStockItems: (data['lowStockItems'] as List<dynamic>?)
        ?.map((e) => LowStockItem.fromMap(e as Map<String, dynamic>))
        .toList(),
    summary: data['summary'] == null
        ? null
        : Summary.fromMap(data['summary'] as Map<String, dynamic>),
    pagination: data['pagination'] == null
        ? null
        : Pagination.fromMap(data['pagination'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'medicines': medicines?.map((e) => e.toMap()).toList(),
    'lowStockItems': lowStockItems?.map((e) => e.toMap()).toList(),
    'summary': summary?.toMap(),
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
    List<Medicine>? medicines,
    List<LowStockItem>? lowStockItems,
    Summary? summary,
    Pagination? pagination,
  }) {
    return Data(
      medicines: medicines ?? this.medicines,
      lowStockItems: lowStockItems ?? this.lowStockItems,
      summary: summary ?? this.summary,
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
      medicines.hashCode ^
      lowStockItems.hashCode ^
      summary.hashCode ^
      pagination.hashCode;
}
