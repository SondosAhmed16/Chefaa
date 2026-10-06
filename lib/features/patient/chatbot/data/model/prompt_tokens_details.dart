import 'dart:convert';

import 'package:collection/collection.dart';

class PromptTokensDetails {
  int? audioTokens;
  int? cachedTokens;

  PromptTokensDetails({this.audioTokens, this.cachedTokens});

  @override
  String toString() {
    return 'PromptTokensDetails(audioTokens: $audioTokens, cachedTokens: $cachedTokens)';
  }

  factory PromptTokensDetails.fromMap(Map<String, dynamic> data) {
    return PromptTokensDetails(
      audioTokens: data['audio_tokens'] as int?,
      cachedTokens: data['cached_tokens'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'audio_tokens': audioTokens,
    'cached_tokens': cachedTokens,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PromptTokensDetails].
  factory PromptTokensDetails.fromJson(String data) {
    return PromptTokensDetails.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [PromptTokensDetails] to a JSON string.
  String toJson() => json.encode(toMap());

  PromptTokensDetails copyWith({int? audioTokens, int? cachedTokens}) {
    return PromptTokensDetails(
      audioTokens: audioTokens ?? this.audioTokens,
      cachedTokens: cachedTokens ?? this.cachedTokens,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PromptTokensDetails) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => audioTokens.hashCode ^ cachedTokens.hashCode;
}
