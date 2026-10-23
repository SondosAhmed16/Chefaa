import 'dart:convert';

import 'package:collection/collection.dart';

class Appointment {
  String? id;
  String? clinic;
  DateTime? date;
  String? slotStart;
  String? slotEnd;

  Appointment({this.id, this.clinic, this.date, this.slotStart, this.slotEnd});

  @override
  String toString() {
    return 'Appointment(id: $id, clinic: $clinic, date: $date, slotStart: $slotStart, slotEnd: $slotEnd)';
  }

  factory Appointment.fromMap(Map<String, dynamic> data) => Appointment(
    id: data['_id'] as String?,
    clinic: data['clinic'] as String?,
    date: data['date'] == null ? null : DateTime.parse(data['date'] as String),
    slotStart: data['slotStart'] as String?,
    slotEnd: data['slotEnd'] as String?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'clinic': clinic,
    'date': date?.toIso8601String(),
    'slotStart': slotStart,
    'slotEnd': slotEnd,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Appointment].
  factory Appointment.fromJson(String data) {
    return Appointment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Appointment] to a JSON string.
  String toJson() => json.encode(toMap());

  Appointment copyWith({
    String? id,
    String? clinic,
    DateTime? date,
    String? slotStart,
    String? slotEnd,
  }) {
    return Appointment(
      id: id ?? this.id,
      clinic: clinic ?? this.clinic,
      date: date ?? this.date,
      slotStart: slotStart ?? this.slotStart,
      slotEnd: slotEnd ?? this.slotEnd,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Appointment) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      clinic.hashCode ^
      date.hashCode ^
      slotStart.hashCode ^
      slotEnd.hashCode;
}
