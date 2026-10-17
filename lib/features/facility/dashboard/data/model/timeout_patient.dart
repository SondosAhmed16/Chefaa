import 'dart:convert';

import 'package:collection/collection.dart';

class TimeoutPatient {
  String? requestId;
  String? patientName;
  String? tests;

  TimeoutPatient({this.requestId, this.patientName, this.tests});

  @override
  String toString() {
    return 'TimeoutPatient(requestId: $requestId, patientName: $patientName, tests: $tests)';
  }

  factory TimeoutPatient.fromMap(Map<String, dynamic> data) {
    return TimeoutPatient(
      requestId: data['requestId'] as String?,
      patientName: data['patientName'] as String?,
      tests: data['tests'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'requestId': requestId,
    'patientName': patientName,
    'tests': tests,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TimeoutPatient].
  factory TimeoutPatient.fromJson(String data) {
    return TimeoutPatient.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TimeoutPatient] to a JSON string.
  String toJson() => json.encode(toMap());

  TimeoutPatient copyWith({
    String? requestId,
    String? patientName,
    String? tests,
  }) {
    return TimeoutPatient(
      requestId: requestId ?? this.requestId,
      patientName: patientName ?? this.patientName,
      tests: tests ?? this.tests,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TimeoutPatient) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      requestId.hashCode ^ patientName.hashCode ^ tests.hashCode;
}
