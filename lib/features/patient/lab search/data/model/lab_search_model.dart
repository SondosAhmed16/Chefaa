import 'dart:convert';

import 'package:collection/collection.dart';

import 'center.dart';

class LabSearchModel {
  bool? success;
  int? count;
  bool? isAiRanked;
  List<CenterModel>? centers;

  LabSearchModel({this.success, this.count, this.isAiRanked, this.centers});

  @override
  String toString() {
    return 'LabSearchModel(success: $success, count: $count, isAiRanked: $isAiRanked, centers: $centers)';
  }

  factory LabSearchModel.fromMap(Map<String, dynamic> data) {
    return LabSearchModel(
      success: data['success'] as bool?,
      count: data['count'] as int?,
      isAiRanked: data['isAIRanked'] as bool?,
      centers: (data['centers'] as List<dynamic>?)
          ?.map((e) => CenterModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'count': count,
    'isAIRanked': isAiRanked,
    'centers': centers?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LabSearchModel].
  factory LabSearchModel.fromJson(String data) {
    return LabSearchModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LabSearchModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LabSearchModel copyWith({
    bool? success,
    int? count,
    bool? isAiRanked,
    List<CenterModel>? centers,
  }) {
    return LabSearchModel(
      success: success ?? this.success,
      count: count ?? this.count,
      isAiRanked: isAiRanked ?? this.isAiRanked,
      centers: centers ?? this.centers,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LabSearchModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^
      count.hashCode ^
      isAiRanked.hashCode ^
      centers.hashCode;
}
