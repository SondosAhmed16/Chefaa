import 'dart:convert';

import 'package:collection/collection.dart';

class Slot {
  int? index;
  int? start;
  int? end;
  String? startTime;
  String? endTime;
  bool? available;
  int? bookedCount;
  int? patientsPerSlot;
  int? remainingInSlot;
  int? remainingInDay;
  String? reason;

  Slot({
    this.index,
    this.start,
    this.end,
    this.startTime,
    this.endTime,
    this.available,
    this.bookedCount,
    this.patientsPerSlot,
    this.remainingInSlot,
    this.remainingInDay,
    this.reason,
  });

  @override
  String toString() {
    return 'Slot(index: $index, start: $start, end: $end, startTime: $startTime, endTime: $endTime, available: $available, bookedCount: $bookedCount, patientsPerSlot: $patientsPerSlot, remainingInSlot: $remainingInSlot, remainingInDay: $remainingInDay, reason: $reason)';
  }

  factory Slot.fromMap(Map<String, dynamic> data) => Slot(
    index: data['index'] as int?,
    start: data['start'] as int?,
    end: data['end'] as int?,
    startTime: data['startTime'] as String?,
    endTime: data['endTime'] as String?,
    available: data['available'] as bool?,
    bookedCount: data['bookedCount'] as int?,
    patientsPerSlot: data['patientsPerSlot'] as int?,
    remainingInSlot: data['remainingInSlot'] as int?,
    remainingInDay: data['remainingInDay'] as int?,
    reason: data['reason'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'index': index,
    'start': start,
    'end': end,
    'startTime': startTime,
    'endTime': endTime,
    'available': available,
    'bookedCount': bookedCount,
    'patientsPerSlot': patientsPerSlot,
    'remainingInSlot': remainingInSlot,
    'remainingInDay': remainingInDay,
    'reason': reason,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Slot].
  factory Slot.fromJson(String data) {
    return Slot.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Slot] to a JSON string.
  String toJson() => json.encode(toMap());

  Slot copyWith({
    int? index,
    int? start,
    int? end,
    String? startTime,
    String? endTime,
    bool? available,
    int? bookedCount,
    int? patientsPerSlot,
    int? remainingInSlot,
    int? remainingInDay,
    String? reason,
  }) {
    return Slot(
      index: index ?? this.index,
      start: start ?? this.start,
      end: end ?? this.end,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      available: available ?? this.available,
      bookedCount: bookedCount ?? this.bookedCount,
      patientsPerSlot: patientsPerSlot ?? this.patientsPerSlot,
      remainingInSlot: remainingInSlot ?? this.remainingInSlot,
      remainingInDay: remainingInDay ?? this.remainingInDay,
      reason: reason ?? this.reason,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Slot) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      index.hashCode ^
      start.hashCode ^
      end.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      available.hashCode ^
      bookedCount.hashCode ^
      patientsPerSlot.hashCode ^
      remainingInSlot.hashCode ^
      remainingInDay.hashCode ^
      reason.hashCode;
}
