import 'dart:convert';

import 'package:collection/collection.dart';

import 'completion_tokens_details.dart';
import 'latency_checkpoint.dart';
import 'prompt_tokens_details.dart';

class Usage {
  int? completionTokens;
  CompletionTokensDetails? completionTokensDetails;
  LatencyCheckpoint? latencyCheckpoint;
  int? promptTokens;
  PromptTokensDetails? promptTokensDetails;
  int? totalTokens;

  Usage({
    this.completionTokens,
    this.completionTokensDetails,
    this.latencyCheckpoint,
    this.promptTokens,
    this.promptTokensDetails,
    this.totalTokens,
  });

  @override
  String toString() {
    return 'Usage(completionTokens: $completionTokens, completionTokensDetails: $completionTokensDetails, latencyCheckpoint: $latencyCheckpoint, promptTokens: $promptTokens, promptTokensDetails: $promptTokensDetails, totalTokens: $totalTokens)';
  }

  factory Usage.fromMap(Map<String, dynamic> data) => Usage(
    completionTokens: data['completion_tokens'] as int?,
    completionTokensDetails: data['completion_tokens_details'] == null
        ? null
        : CompletionTokensDetails.fromMap(
            data['completion_tokens_details'] as Map<String, dynamic>,
          ),
    latencyCheckpoint: data['latency_checkpoint'] == null
        ? null
        : LatencyCheckpoint.fromMap(
            data['latency_checkpoint'] as Map<String, dynamic>,
          ),
    promptTokens: data['prompt_tokens'] as int?,
    promptTokensDetails: data['prompt_tokens_details'] == null
        ? null
        : PromptTokensDetails.fromMap(
            data['prompt_tokens_details'] as Map<String, dynamic>,
          ),
    totalTokens: data['total_tokens'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'completion_tokens': completionTokens,
    'completion_tokens_details': completionTokensDetails?.toMap(),
    'latency_checkpoint': latencyCheckpoint?.toMap(),
    'prompt_tokens': promptTokens,
    'prompt_tokens_details': promptTokensDetails?.toMap(),
    'total_tokens': totalTokens,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Usage].
  factory Usage.fromJson(String data) {
    return Usage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Usage] to a JSON string.
  String toJson() => json.encode(toMap());

  Usage copyWith({
    int? completionTokens,
    CompletionTokensDetails? completionTokensDetails,
    LatencyCheckpoint? latencyCheckpoint,
    int? promptTokens,
    PromptTokensDetails? promptTokensDetails,
    int? totalTokens,
  }) {
    return Usage(
      completionTokens: completionTokens ?? this.completionTokens,
      completionTokensDetails:
          completionTokensDetails ?? this.completionTokensDetails,
      latencyCheckpoint: latencyCheckpoint ?? this.latencyCheckpoint,
      promptTokens: promptTokens ?? this.promptTokens,
      promptTokensDetails: promptTokensDetails ?? this.promptTokensDetails,
      totalTokens: totalTokens ?? this.totalTokens,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Usage) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      completionTokens.hashCode ^
      completionTokensDetails.hashCode ^
      latencyCheckpoint.hashCode ^
      promptTokens.hashCode ^
      promptTokensDetails.hashCode ^
      totalTokens.hashCode;
}
