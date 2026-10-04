import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class AiLabReport {
  bool? success;
  Data? data;

  AiLabReport({this.success, this.data});

  @override
  String toString() => 'AiLabReport(success: $success, data: $data)';

  factory AiLabReport.fromMap(Map<String, dynamic> data) => AiLabReport(
    success: data['success'] as bool?,
    data: data['data'] == null
        ? null
        : Data.fromMap(data['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AiLabReport].
  factory AiLabReport.fromJson(String data) {
    return AiLabReport.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AiLabReport] to a JSON string.
  String toJson() => json.encode(toMap());

  AiLabReport copyWith({bool? success, Data? data}) {
    return AiLabReport(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AiLabReport) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
