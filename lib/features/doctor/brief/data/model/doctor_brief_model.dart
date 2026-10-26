import 'dart:convert';

import 'package:collection/collection.dart';

class DoctorBriefModel {
  DateTime? generatedAt;
  String? lang;
  String? brief;

  DoctorBriefModel({this.generatedAt, this.lang, this.brief});

  @override
  String toString() {
    return 'DoctorBriefModel(generatedAt: $generatedAt, lang: $lang, brief: $brief)';
  }

  factory DoctorBriefModel.fromMap(Map<String, dynamic> data) {
    return DoctorBriefModel(
      generatedAt: data['generatedAt'] == null
          ? null
          : DateTime.parse(data['generatedAt'] as String),
      lang: data['lang'] as String?,
      brief: data['brief'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'generatedAt': generatedAt?.toIso8601String(),
    'lang': lang,
    'brief': brief,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DoctorBriefModel].
  factory DoctorBriefModel.fromJson(String data) {
    return DoctorBriefModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DoctorBriefModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DoctorBriefModel copyWith({
    DateTime? generatedAt,
    String? lang,
    String? brief,
  }) {
    return DoctorBriefModel(
      generatedAt: generatedAt ?? this.generatedAt,
      lang: lang ?? this.lang,
      brief: brief ?? this.brief,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DoctorBriefModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => generatedAt.hashCode ^ lang.hashCode ^ brief.hashCode;
}
