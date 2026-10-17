import 'dart:convert';

import 'package:collection/collection.dart';

class TodaysRequest {
  String? ref;
  String? patientName;
  String? analysisName;
  String? bookedAt;
  String? status;

  TodaysRequest({
    this.ref,
    this.patientName,
    this.analysisName,
    this.bookedAt,
    this.status,
  });

  @override
  String toString() {
    return 'TodaysRequest(ref: $ref, patientName: $patientName, analysisName: $analysisName, bookedAt: $bookedAt, status: $status)';
  }

  factory TodaysRequest.fromMap(Map<String, dynamic> data) => TodaysRequest(
    ref: data['ref'] as String?,
    patientName: data['patientName'] as String?,
    analysisName: data['analysisName'] as String?,
    bookedAt: data['bookedAt'] as String?,
    status: data['status'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'ref': ref,
    'patientName': patientName,
    'analysisName': analysisName,
    'bookedAt': bookedAt,
    'status': status,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TodaysRequest].
  factory TodaysRequest.fromJson(String data) {
    return TodaysRequest.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TodaysRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  TodaysRequest copyWith({
    String? ref,
    String? patientName,
    String? analysisName,
    String? bookedAt,
    String? status,
  }) {
    return TodaysRequest(
      ref: ref ?? this.ref,
      patientName: patientName ?? this.patientName,
      analysisName: analysisName ?? this.analysisName,
      bookedAt: bookedAt ?? this.bookedAt,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TodaysRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      ref.hashCode ^
      patientName.hashCode ^
      analysisName.hashCode ^
      bookedAt.hashCode ^
      status.hashCode;
}
