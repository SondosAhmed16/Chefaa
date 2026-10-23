import 'dart:convert';

import 'package:collection/collection.dart';

import 'break.dart';

class Day {
  String? day;
  bool? isActive;
  int? open;
  int? close;
  List<Break>? breaks;
  dynamic slotDuration;
  dynamic dailyCapacity;
  dynamic patientsPerSlot;
  bool? isDayLocked;
  bool? isBookingLocked;

  Day({
    this.day,
    this.isActive,
    this.open,
    this.close,
    this.breaks,
    this.slotDuration,
    this.dailyCapacity,
    this.patientsPerSlot,
    this.isDayLocked,
    this.isBookingLocked,
  });

  @override
  String toString() {
    return 'Day(day: $day, isActive: $isActive, open: $open, close: $close, breaks: $breaks, slotDuration: $slotDuration, dailyCapacity: $dailyCapacity, patientsPerSlot: $patientsPerSlot, isDayLocked: $isDayLocked, isBookingLocked: $isBookingLocked)';
  }

  factory Day.fromMap(Map<String, dynamic> data) => Day(
    day: data['day'] as String?,
    isActive: data['isActive'] as bool?,
    open: data['open'] as int?,
    close: data['close'] as int?,
    breaks: (data['breaks'] as List<dynamic>?)
        ?.map((e) => Break.fromMap(e as Map<String, dynamic>))
        .toList(),
    slotDuration: data['slotDuration'] as dynamic,
    dailyCapacity: data['dailyCapacity'] as dynamic,
    patientsPerSlot: data['patientsPerSlot'] as dynamic,
    isDayLocked: data['isDayLocked'] as bool?,
    isBookingLocked: data['isBookingLocked'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'day': day,
    'isActive': isActive,
    'open': open,
    'close': close,
    'breaks': breaks?.map((e) => e.toMap()).toList(),
    'slotDuration': slotDuration,
    'dailyCapacity': dailyCapacity,
    'patientsPerSlot': patientsPerSlot,
    'isDayLocked': isDayLocked,
    'isBookingLocked': isBookingLocked,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Day].
  factory Day.fromJson(String data) {
    return Day.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Day] to a JSON string.
  String toJson() => json.encode(toMap());

  Day copyWith({
    String? day,
    bool? isActive,
    int? open,
    int? close,
    List<Break>? breaks,
    dynamic slotDuration,
    dynamic dailyCapacity,
    dynamic patientsPerSlot,
    bool? isDayLocked,
    bool? isBookingLocked,
  }) {
    return Day(
      day: day ?? this.day,
      isActive: isActive ?? this.isActive,
      open: open ?? this.open,
      close: close ?? this.close,
      breaks: breaks ?? this.breaks,
      slotDuration: slotDuration ?? this.slotDuration,
      dailyCapacity: dailyCapacity ?? this.dailyCapacity,
      patientsPerSlot: patientsPerSlot ?? this.patientsPerSlot,
      isDayLocked: isDayLocked ?? this.isDayLocked,
      isBookingLocked: isBookingLocked ?? this.isBookingLocked,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Day) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      day.hashCode ^
      isActive.hashCode ^
      open.hashCode ^
      close.hashCode ^
      breaks.hashCode ^
      slotDuration.hashCode ^
      dailyCapacity.hashCode ^
      patientsPerSlot.hashCode ^
      isDayLocked.hashCode ^
      isBookingLocked.hashCode;
}
