import 'dart:convert';

import 'package:collection/collection.dart';

class WorkingHour {
  String? days;
  String? time;
  String? id;

  WorkingHour({this.days, this.time, this.id});

  @override
  String toString() => 'WorkingHour(days: $days, time: $time, id: $id)';

  factory WorkingHour.fromMap(Map<String, dynamic> data) => WorkingHour(
    days: data['days'] as String?,
    time: data['time'] as String?,
    id: data['_id'] as String?,
  );

  Map<String, dynamic> toMap() => {'days': days, 'time': time, '_id': id};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WorkingHour].
  factory WorkingHour.fromJson(String data) {
    return WorkingHour.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WorkingHour] to a JSON string.
  String toJson() => json.encode(toMap());

  WorkingHour copyWith({String? days, String? time, String? id}) {
    return WorkingHour(
      days: days ?? this.days,
      time: time ?? this.time,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! WorkingHour) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => days.hashCode ^ time.hashCode ^ id.hashCode;
}
