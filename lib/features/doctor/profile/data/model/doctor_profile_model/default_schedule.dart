import 'dart:convert';

import 'package:collection/collection.dart';

import 'day.dart';

class DefaultSchedule {
  List<Day>? days;
  int? slotDuration;
  int? dailyCapacity;
  int? patientsPerSlot;

  DefaultSchedule({
    this.days,
    this.slotDuration,
    this.dailyCapacity,
    this.patientsPerSlot,
  });

  @override
  String toString() {
    return 'DefaultSchedule(days: $days, slotDuration: $slotDuration, dailyCapacity: $dailyCapacity, patientsPerSlot: $patientsPerSlot)';
  }

  factory DefaultSchedule.fromMap(Map<String, dynamic> data) {
    return DefaultSchedule(
      days: (data['days'] as List<dynamic>?)
          ?.map((e) => Day.fromMap(e as Map<String, dynamic>))
          .toList(),
      slotDuration: data['slotDuration'] as int?,
      dailyCapacity: data['dailyCapacity'] as int?,
      patientsPerSlot: data['patientsPerSlot'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'days': days?.map((e) => e.toMap()).toList(),
    'slotDuration': slotDuration,
    'dailyCapacity': dailyCapacity,
    'patientsPerSlot': patientsPerSlot,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DefaultSchedule].
  factory DefaultSchedule.fromJson(String data) {
    return DefaultSchedule.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DefaultSchedule] to a JSON string.
  String toJson() => json.encode(toMap());

  DefaultSchedule copyWith({
    List<Day>? days,
    int? slotDuration,
    int? dailyCapacity,
    int? patientsPerSlot,
  }) {
    return DefaultSchedule(
      days: days ?? this.days,
      slotDuration: slotDuration ?? this.slotDuration,
      dailyCapacity: dailyCapacity ?? this.dailyCapacity,
      patientsPerSlot: patientsPerSlot ?? this.patientsPerSlot,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DefaultSchedule) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      days.hashCode ^
      slotDuration.hashCode ^
      dailyCapacity.hashCode ^
      patientsPerSlot.hashCode;
}
