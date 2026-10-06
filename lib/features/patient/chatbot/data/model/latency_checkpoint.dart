import 'dart:convert';

import 'package:collection/collection.dart';

class LatencyCheckpoint {
  int? engineTbtMs;
  int? engineTtftMs;
  int? engineTtltMs;
  int? preInferenceMs;
  int? serviceTbtMs;
  int? serviceTtftMs;
  int? serviceTtltMs;
  int? userVisibleTtftMs;

  LatencyCheckpoint({
    this.engineTbtMs,
    this.engineTtftMs,
    this.engineTtltMs,
    this.preInferenceMs,
    this.serviceTbtMs,
    this.serviceTtftMs,
    this.serviceTtltMs,
    this.userVisibleTtftMs,
  });

  @override
  String toString() {
    return 'LatencyCheckpoint(engineTbtMs: $engineTbtMs, engineTtftMs: $engineTtftMs, engineTtltMs: $engineTtltMs, preInferenceMs: $preInferenceMs, serviceTbtMs: $serviceTbtMs, serviceTtftMs: $serviceTtftMs, serviceTtltMs: $serviceTtltMs, userVisibleTtftMs: $userVisibleTtftMs)';
  }

  factory LatencyCheckpoint.fromMap(Map<String, dynamic> data) {
    return LatencyCheckpoint(
      engineTbtMs: data['engine_tbt_ms'] as int?,
      engineTtftMs: data['engine_ttft_ms'] as int?,
      engineTtltMs: data['engine_ttlt_ms'] as int?,
      preInferenceMs: data['pre_inference_ms'] as int?,
      serviceTbtMs: data['service_tbt_ms'] as int?,
      serviceTtftMs: data['service_ttft_ms'] as int?,
      serviceTtltMs: data['service_ttlt_ms'] as int?,
      userVisibleTtftMs: data['user_visible_ttft_ms'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'engine_tbt_ms': engineTbtMs,
    'engine_ttft_ms': engineTtftMs,
    'engine_ttlt_ms': engineTtltMs,
    'pre_inference_ms': preInferenceMs,
    'service_tbt_ms': serviceTbtMs,
    'service_ttft_ms': serviceTtftMs,
    'service_ttlt_ms': serviceTtltMs,
    'user_visible_ttft_ms': userVisibleTtftMs,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LatencyCheckpoint].
  factory LatencyCheckpoint.fromJson(String data) {
    return LatencyCheckpoint.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LatencyCheckpoint] to a JSON string.
  String toJson() => json.encode(toMap());

  LatencyCheckpoint copyWith({
    int? engineTbtMs,
    int? engineTtftMs,
    int? engineTtltMs,
    int? preInferenceMs,
    int? serviceTbtMs,
    int? serviceTtftMs,
    int? serviceTtltMs,
    int? userVisibleTtftMs,
  }) {
    return LatencyCheckpoint(
      engineTbtMs: engineTbtMs ?? this.engineTbtMs,
      engineTtftMs: engineTtftMs ?? this.engineTtftMs,
      engineTtltMs: engineTtltMs ?? this.engineTtltMs,
      preInferenceMs: preInferenceMs ?? this.preInferenceMs,
      serviceTbtMs: serviceTbtMs ?? this.serviceTbtMs,
      serviceTtftMs: serviceTtftMs ?? this.serviceTtftMs,
      serviceTtltMs: serviceTtltMs ?? this.serviceTtltMs,
      userVisibleTtftMs: userVisibleTtftMs ?? this.userVisibleTtftMs,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LatencyCheckpoint) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      engineTbtMs.hashCode ^
      engineTtftMs.hashCode ^
      engineTtltMs.hashCode ^
      preInferenceMs.hashCode ^
      serviceTbtMs.hashCode ^
      serviceTtftMs.hashCode ^
      serviceTtltMs.hashCode ^
      userVisibleTtftMs.hashCode;
}
