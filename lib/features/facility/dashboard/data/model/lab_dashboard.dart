import 'dart:convert';

import 'package:collection/collection.dart';

import 'results_uploaded_today.dart';
import 'stats.dart';
import 'todays_request.dart';

class LabDashboard {
  bool? success;
  String? labName;
  Stats? stats;
  List<TodaysRequest>? todaysRequests;
  List<ResultsUploadedToday>? resultsUploadedToday;

  LabDashboard({
    this.success,
    this.labName,
    this.stats,
    this.todaysRequests,
    this.resultsUploadedToday,
  });

  @override
  String toString() {
    return 'LabDashboard(success: $success, labName: $labName, stats: $stats, todaysRequests: $todaysRequests, resultsUploadedToday: $resultsUploadedToday)';
  }

  factory LabDashboard.fromMap(Map<String, dynamic> data) => LabDashboard(
    success: data['success'] as bool?,
    labName: data['labName'] as String?,
    stats: data['stats'] == null
        ? null
        : Stats.fromMap(data['stats'] as Map<String, dynamic>),
    todaysRequests: (data['todaysRequests'] as List<dynamic>?)
        ?.map((e) => TodaysRequest.fromMap(e as Map<String, dynamic>))
        .toList(),
    resultsUploadedToday: (data['resultsUploadedToday'] as List<dynamic>?)
        ?.map((e) => ResultsUploadedToday.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'success': success,
    'labName': labName,
    'stats': stats?.toMap(),
    'todaysRequests': todaysRequests?.map((e) => e.toMap()).toList(),
    'resultsUploadedToday': resultsUploadedToday
        ?.map((e) => e.toMap())
        .toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LabDashboard].
  factory LabDashboard.fromJson(String data) {
    return LabDashboard.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LabDashboard] to a JSON string.
  String toJson() => json.encode(toMap());

  LabDashboard copyWith({
    bool? success,
    String? labName,
    Stats? stats,
    List<TodaysRequest>? todaysRequests,
    List<ResultsUploadedToday>? resultsUploadedToday,
  }) {
    return LabDashboard(
      success: success ?? this.success,
      labName: labName ?? this.labName,
      stats: stats ?? this.stats,
      todaysRequests: todaysRequests ?? this.todaysRequests,
      resultsUploadedToday: resultsUploadedToday ?? this.resultsUploadedToday,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LabDashboard) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^
      labName.hashCode ^
      stats.hashCode ^
      todaysRequests.hashCode ^
      resultsUploadedToday.hashCode;
}
