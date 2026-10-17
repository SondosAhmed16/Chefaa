import 'dart:convert';

import 'package:collection/collection.dart';

import 'timeout_patient.dart';

class Stats {
  int? todaysRequests;
  int? completedToday;
  int? timeoutRequests;
  List<TimeoutPatient>? timeoutPatients;

  Stats({
    this.todaysRequests,
    this.completedToday,
    this.timeoutRequests,
    this.timeoutPatients,
  });

  @override
  String toString() {
    return 'Stats(todaysRequests: $todaysRequests, completedToday: $completedToday, timeoutRequests: $timeoutRequests, timeoutPatients: $timeoutPatients)';
  }

  factory Stats.fromMap(Map<String, dynamic> data) => Stats(
    todaysRequests: data['todaysRequests'] as int?,
    completedToday: data['completedToday'] as int?,
    timeoutRequests: data['timeoutRequests'] as int?,
    timeoutPatients: (data['timeoutPatients'] as List<dynamic>?)
        ?.map((e) => TimeoutPatient.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'todaysRequests': todaysRequests,
    'completedToday': completedToday,
    'timeoutRequests': timeoutRequests,
    'timeoutPatients': timeoutPatients?.map((e) => e.toMap()).toList(),
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

  Stats copyWith({
    int? todaysRequests,
    int? completedToday,
    int? timeoutRequests,
    List<TimeoutPatient>? timeoutPatients,
  }) {
    return Stats(
      todaysRequests: todaysRequests ?? this.todaysRequests,
      completedToday: completedToday ?? this.completedToday,
      timeoutRequests: timeoutRequests ?? this.timeoutRequests,
      timeoutPatients: timeoutPatients ?? this.timeoutPatients,
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
      todaysRequests.hashCode ^
      completedToday.hashCode ^
      timeoutRequests.hashCode ^
      timeoutPatients.hashCode;
}
