import 'dart:convert';

import 'package:collection/collection.dart';

class Finding {
  String? testName;
  String? result;
  String? unit;
  String? status;
  String? interpretation;

  Finding({
    this.testName,
    this.result,
    this.unit,
    this.status,
    this.interpretation,
  });

  @override
  String toString() {
    return 'Finding(testName: $testName, result: $result, unit: $unit, status: $status, interpretation: $interpretation)';
  }

  factory Finding.fromMap(Map<String, dynamic> data) => Finding(
    testName: data['testName'] as String?,
    result: data['result']?.toString(),
    unit: data['unit'] as String?,
    status: data['status'] as String?,
    interpretation: data['interpretation'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'testName': testName,
    'result': result,
    'unit': unit,
    'status': status,
    'interpretation': interpretation,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Finding].
  factory Finding.fromJson(String data) {
    return Finding.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Finding] to a JSON string.
  String toJson() => json.encode(toMap());

  Finding copyWith({
    String? testName,
    String? result,
    String? unit,
    String? status,
    String? interpretation,
  }) {
    return Finding(
      testName: testName ?? this.testName,
      result: result ?? this.result,
      unit: unit ?? this.unit,
      status: status ?? this.status,
      interpretation: interpretation ?? this.interpretation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Finding) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      testName.hashCode ^
      result.hashCode ^
      unit.hashCode ^
      status.hashCode ^
      interpretation.hashCode;
}
