import 'dart:convert';

import 'package:collection/collection.dart';

class Stats {
  double? rating;
  int? totalMedicines;
  int? totalOrders;

  Stats({this.rating, this.totalMedicines, this.totalOrders});

  @override
  String toString() {
    return 'Stats(rating: $rating, totalMedicines: $totalMedicines, totalOrders: $totalOrders)';
  }

  factory Stats.fromMap(Map<String, dynamic> data) => Stats(
    rating: (data['rating'] as num?)?.toDouble(),
    totalMedicines: data['totalMedicines'] as int?,
    totalOrders: data['totalOrders'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'rating': rating,
    'totalMedicines': totalMedicines,
    'totalOrders': totalOrders,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Stats].
  factory Stats.fromJson(String data) {
    return Stats.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Stats] to a JSON string.
  String toJson() => json.encode(toMap());

  Stats copyWith({double? rating, int? totalMedicines, int? totalOrders}) {
    return Stats(
      rating: rating ?? this.rating,
      totalMedicines: totalMedicines ?? this.totalMedicines,
      totalOrders: totalOrders ?? this.totalOrders,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Stats) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      rating.hashCode ^ totalMedicines.hashCode ^ totalOrders.hashCode;
}
