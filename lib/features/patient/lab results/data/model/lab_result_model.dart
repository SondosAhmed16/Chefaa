import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class LabResultModel {
  bool? success;
  int? count;
  List<Result>? results;

  LabResultModel({this.success, this.count, this.results});

  @override
  String toString() {
    return 'LabResultModel(success: $success, count: $count, results: $results)';
  }

  factory LabResultModel.fromMap(Map<String, dynamic> data) {
    return LabResultModel(
      success: data['success'] as bool?,
      count: data['count'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => Result.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'count': count,
    'results': results?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LabResultModel].
  factory LabResultModel.fromJson(String data) {
    return LabResultModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LabResultModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LabResultModel copyWith({bool? success, int? count, List<Result>? results}) {
    return LabResultModel(
      success: success ?? this.success,
      count: count ?? this.count,
      results: results ?? this.results,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LabResultModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ count.hashCode ^ results.hashCode;
}
