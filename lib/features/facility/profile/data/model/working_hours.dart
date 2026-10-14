import 'dart:convert';

import 'package:collection/collection.dart';

class WorkingHours {
  int? open;
  int? close;

  WorkingHours({this.open, this.close});

  @override
  String toString() => 'WorkingHours(open: $open, close: $close)';

  factory WorkingHours.fromMap(Map<String, dynamic> data) =>
      WorkingHours(open: data['open'] as int?, close: data['close'] as int?);

  Map<String, dynamic> toMap() => {'open': open, 'close': close};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WorkingHours].
  factory WorkingHours.fromJson(String data) {
    return WorkingHours.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WorkingHours] to a JSON string.
  String toJson() => json.encode(toMap());

  WorkingHours copyWith({int? open, int? close}) {
    return WorkingHours(open: open ?? this.open, close: close ?? this.close);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! WorkingHours) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => open.hashCode ^ close.hashCode;
}
