import 'dart:convert';

import 'package:collection/collection.dart';

import 'slot.dart';

class SlotModel {
  String? date;
  String? day;
  bool? isPast;
  String? status;
  int? open;
  int? close;
  int? slotDuration;
  int? dailyCapacity;
  int? patientsPerSlot;
  int? totalBookedToday;
  int? totalSlots;
  bool? hasAppointments;
  List<dynamic>? breaks;
  List<Slot>? slots;

  SlotModel({
    this.date,
    this.day,
    this.isPast,
    this.status,
    this.open,
    this.close,
    this.slotDuration,
    this.dailyCapacity,
    this.patientsPerSlot,
    this.totalBookedToday,
    this.totalSlots,
    this.hasAppointments,
    this.breaks,
    this.slots,
  });

  @override
  String toString() {
    return 'SlotModel(date: $date, day: $day, isPast: $isPast, status: $status, open: $open, close: $close, slotDuration: $slotDuration, dailyCapacity: $dailyCapacity, patientsPerSlot: $patientsPerSlot, totalBookedToday: $totalBookedToday, totalSlots: $totalSlots, hasAppointments: $hasAppointments, breaks: $breaks, slots: $slots)';
  }

  factory SlotModel.fromMap(Map<String, dynamic> data) => SlotModel(
    date: data['date'] as String?,
    day: data['day'] as String?,
    isPast: data['isPast'] as bool?,
    status: data['status'] as String?,
    open: data['open'] as int?,
    close: data['close'] as int?,
    slotDuration: data['slotDuration'] as int?,
    dailyCapacity: data['dailyCapacity'] as int?,
    patientsPerSlot: data['patientsPerSlot'] as int?,
    totalBookedToday: data['totalBookedToday'] as int?,
    totalSlots: data['totalSlots'] as int?,
    hasAppointments: data['hasAppointments'] as bool?,
    breaks: data['breaks'] as List<dynamic>?,
    slots: (data['slots'] as List<dynamic>?)
        ?.map((e) => Slot.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'date': date,
    'day': day,
    'isPast': isPast,
    'status': status,
    'open': open,
    'close': close,
    'slotDuration': slotDuration,
    'dailyCapacity': dailyCapacity,
    'patientsPerSlot': patientsPerSlot,
    'totalBookedToday': totalBookedToday,
    'totalSlots': totalSlots,
    'hasAppointments': hasAppointments,
    'breaks': breaks,
    'slots': slots?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SlotModel].
  factory SlotModel.fromJson(String data) {
    return SlotModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SlotModel] to a JSON string.
  String toJson() => json.encode(toMap());

  SlotModel copyWith({
    String? date,
    String? day,
    bool? isPast,
    String? status,
    int? open,
    int? close,
    int? slotDuration,
    int? dailyCapacity,
    int? patientsPerSlot,
    int? totalBookedToday,
    int? totalSlots,
    bool? hasAppointments,
    List<dynamic>? breaks,
    List<Slot>? slots,
  }) {
    return SlotModel(
      date: date ?? this.date,
      day: day ?? this.day,
      isPast: isPast ?? this.isPast,
      status: status ?? this.status,
      open: open ?? this.open,
      close: close ?? this.close,
      slotDuration: slotDuration ?? this.slotDuration,
      dailyCapacity: dailyCapacity ?? this.dailyCapacity,
      patientsPerSlot: patientsPerSlot ?? this.patientsPerSlot,
      totalBookedToday: totalBookedToday ?? this.totalBookedToday,
      totalSlots: totalSlots ?? this.totalSlots,
      hasAppointments: hasAppointments ?? this.hasAppointments,
      breaks: breaks ?? this.breaks,
      slots: slots ?? this.slots,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SlotModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      date.hashCode ^
      day.hashCode ^
      isPast.hashCode ^
      status.hashCode ^
      open.hashCode ^
      close.hashCode ^
      slotDuration.hashCode ^
      dailyCapacity.hashCode ^
      patientsPerSlot.hashCode ^
      totalBookedToday.hashCode ^
      totalSlots.hashCode ^
      hasAppointments.hashCode ^
      breaks.hashCode ^
      slots.hashCode;
}
