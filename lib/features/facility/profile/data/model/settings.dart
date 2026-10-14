import 'dart:convert';

import 'package:collection/collection.dart';

class Settings {
  bool? homeSampleCollection;
  bool? aiRecommendations;
  bool? insuranceAccepted;

  Settings({
    this.homeSampleCollection,
    this.aiRecommendations,
    this.insuranceAccepted,
  });

  @override
  String toString() {
    return 'Settings(homeSampleCollection: $homeSampleCollection, aiRecommendations: $aiRecommendations, insuranceAccepted: $insuranceAccepted)';
  }

  factory Settings.fromMap(Map<String, dynamic> data) => Settings(
    homeSampleCollection: data['homeSampleCollection'] as bool?,
    aiRecommendations: data['aiRecommendations'] as bool?,
    insuranceAccepted: data['insuranceAccepted'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'homeSampleCollection': homeSampleCollection,
    'aiRecommendations': aiRecommendations,
    'insuranceAccepted': insuranceAccepted,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Settings].
  factory Settings.fromJson(String data) {
    return Settings.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Settings] to a JSON string.
  String toJson() => json.encode(toMap());

  Settings copyWith({
    bool? homeSampleCollection,
    bool? aiRecommendations,
    bool? insuranceAccepted,
  }) {
    return Settings(
      homeSampleCollection: homeSampleCollection ?? this.homeSampleCollection,
      aiRecommendations: aiRecommendations ?? this.aiRecommendations,
      insuranceAccepted: insuranceAccepted ?? this.insuranceAccepted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Settings) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      homeSampleCollection.hashCode ^
      aiRecommendations.hashCode ^
      insuranceAccepted.hashCode;
}
