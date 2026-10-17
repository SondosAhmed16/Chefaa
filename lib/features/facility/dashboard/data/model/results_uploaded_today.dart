import 'dart:convert';

import 'package:collection/collection.dart';

class ResultsUploadedToday {
  String? patientName;
  String? analysisName;
  String? uploadedAt;
  bool? patientNotified;

  ResultsUploadedToday({
    this.patientName,
    this.analysisName,
    this.uploadedAt,
    this.patientNotified,
  });

  @override
  String toString() {
    return 'ResultsUploadedToday(patientName: $patientName, analysisName: $analysisName, uploadedAt: $uploadedAt, patientNotified: $patientNotified)';
  }

  factory ResultsUploadedToday.fromMap(Map<String, dynamic> data) {
    return ResultsUploadedToday(
      patientName: data['patientName'] as String?,
      analysisName: data['analysisName'] as String?,
      uploadedAt: data['uploadedAt'] as String?,
      patientNotified: data['patientNotified'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
    'patientName': patientName,
    'analysisName': analysisName,
    'uploadedAt': uploadedAt,
    'patientNotified': patientNotified,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResultsUploadedToday].
  factory ResultsUploadedToday.fromJson(String data) {
    return ResultsUploadedToday.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ResultsUploadedToday] to a JSON string.
  String toJson() => json.encode(toMap());

  ResultsUploadedToday copyWith({
    String? patientName,
    String? analysisName,
    String? uploadedAt,
    bool? patientNotified,
  }) {
    return ResultsUploadedToday(
      patientName: patientName ?? this.patientName,
      analysisName: analysisName ?? this.analysisName,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      patientNotified: patientNotified ?? this.patientNotified,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ResultsUploadedToday) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      patientName.hashCode ^
      analysisName.hashCode ^
      uploadedAt.hashCode ^
      patientNotified.hashCode;
}
