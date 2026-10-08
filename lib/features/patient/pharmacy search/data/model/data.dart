import 'dart:convert';

import 'package:collection/collection.dart';

import 'medicine.dart';
import 'most_ordered.dart';
import 'pagination.dart';

class Data {
  List<Medicine>? medicines;
  List<MostOrdered>? mostOrdered;
  Pagination? pagination;

  Data({this.medicines, this.mostOrdered, this.pagination});

  @override
  String toString() {
    return 'Data(medicines: $medicines, mostOrdered: $mostOrdered, pagination: $pagination)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    medicines: (data['medicines'] as List<dynamic>?)
        ?.map((e) => Medicine.fromMap(e as Map<String, dynamic>))
        .toList(),
    mostOrdered: (data['mostOrdered'] as List<dynamic>?)
        ?.map((e) => MostOrdered.fromMap(e as Map<String, dynamic>))
        .toList(),
    pagination: data['pagination'] == null
        ? null
        : Pagination.fromMap(data['pagination'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'medicines': medicines?.map((e) => e.toMap()).toList(),
    'mostOrdered': mostOrdered?.map((e) => e.toMap()).toList(),
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
    List<MostOrdered>? mostOrdered,
    Pagination? pagination,
  }) {
    return Data(
      medicines: medicines ?? this.medicines,
      mostOrdered: mostOrdered ?? this.mostOrdered,
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
      medicines.hashCode ^ mostOrdered.hashCode ^ pagination.hashCode;
}
