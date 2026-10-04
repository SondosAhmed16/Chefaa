import 'dart:convert';

import 'package:collection/collection.dart';

import 'finding.dart';

class Data {
  String? patientName;
  List<Finding>? findings;
  int? dangerScore;
  String? summary;
  List<String>? tips;

  Data({
    this.patientName,
    this.findings,
    this.dangerScore,
    this.summary,
    this.tips,
  });

  @override
  String toString() {
    return 'Data(patientName: $patientName, findings: $findings, dangerScore: $dangerScore, summary: $summary, tips: $tips)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    patientName: data['patientName'] as String?,
    findings: (data['findings'] as List<dynamic>?)
        ?.map((e) => Finding.fromMap(e as Map<String, dynamic>))
        .toList(),
    dangerScore: data['dangerScore'] as int?,
    summary: data['summary'] as String?,
    tips: (data['tips'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toMap() => {
    'patientName': patientName,
    'findings': findings?.map((e) => e.toMap()).toList(),
    'dangerScore': dangerScore,
    'summary': summary,
    'tips': tips,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    String? patientName,
    List<Finding>? findings,
    int? dangerScore,
    String? summary,
    List<String>? tips,
  }) {
    return Data(
      patientName: patientName ?? this.patientName,
      findings: findings ?? this.findings,
      dangerScore: dangerScore ?? this.dangerScore,
      summary: summary ?? this.summary,
      tips: tips ?? this.tips,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      patientName.hashCode ^
      findings.hashCode ^
      dangerScore.hashCode ^
      summary.hashCode ^
      tips.hashCode;
}
