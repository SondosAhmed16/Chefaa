import 'dart:convert';

import 'package:collection/collection.dart';

class CompletionTokensDetails {
  int? acceptedPredictionTokens;
  int? audioTokens;
  int? reasoningTokens;
  int? rejectedPredictionTokens;

  CompletionTokensDetails({
    this.acceptedPredictionTokens,
    this.audioTokens,
    this.reasoningTokens,
    this.rejectedPredictionTokens,
  });

  @override
  String toString() {
    return 'CompletionTokensDetails(acceptedPredictionTokens: $acceptedPredictionTokens, audioTokens: $audioTokens, reasoningTokens: $reasoningTokens, rejectedPredictionTokens: $rejectedPredictionTokens)';
  }

  factory CompletionTokensDetails.fromMap(Map<String, dynamic> data) {
    return CompletionTokensDetails(
      acceptedPredictionTokens: data['accepted_prediction_tokens'] as int?,
      audioTokens: data['audio_tokens'] as int?,
      reasoningTokens: data['reasoning_tokens'] as int?,
      rejectedPredictionTokens: data['rejected_prediction_tokens'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'accepted_prediction_tokens': acceptedPredictionTokens,
    'audio_tokens': audioTokens,
    'reasoning_tokens': reasoningTokens,
    'rejected_prediction_tokens': rejectedPredictionTokens,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CompletionTokensDetails].
  factory CompletionTokensDetails.fromJson(String data) {
    return CompletionTokensDetails.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [CompletionTokensDetails] to a JSON string.
  String toJson() => json.encode(toMap());

  CompletionTokensDetails copyWith({
    int? acceptedPredictionTokens,
    int? audioTokens,
    int? reasoningTokens,
    int? rejectedPredictionTokens,
  }) {
    return CompletionTokensDetails(
      acceptedPredictionTokens:
          acceptedPredictionTokens ?? this.acceptedPredictionTokens,
      audioTokens: audioTokens ?? this.audioTokens,
      reasoningTokens: reasoningTokens ?? this.reasoningTokens,
      rejectedPredictionTokens:
          rejectedPredictionTokens ?? this.rejectedPredictionTokens,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CompletionTokensDetails) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      acceptedPredictionTokens.hashCode ^
      audioTokens.hashCode ^
      reasoningTokens.hashCode ^
      rejectedPredictionTokens.hashCode;
}
