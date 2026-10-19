import 'dart:convert';

import 'package:collection/collection.dart';

class Break {
  int? start;
  int? end;
  String? label;

  Break({this.start, this.end, this.label});

  @override
  String toString() => 'Break(start: $start, end: $end, label: $label)';

  factory Break.fromMap(Map<String, dynamic> data) => Break(
    start: data['start'] as int?,
    end: data['end'] as int?,
    label: data['label'] as String?,
  );

  Map<String, dynamic> toMap() => {'start': start, 'end': end, 'label': label};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Break].
  factory Break.fromJson(String data) {
    return Break.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Break] to a JSON string.
  String toJson() => json.encode(toMap());

  Break copyWith({int? start, int? end, String? label}) {
    return Break(
      start: start ?? this.start,
      end: end ?? this.end,
      label: label ?? this.label,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Break) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ label.hashCode;
}
