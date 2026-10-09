import 'dart:convert';

import 'package:collection/collection.dart';

class UsageInstructions {
  String? indications;
  String? sideEffects;
  String? dosageInstructions;

  UsageInstructions({
    this.indications,
    this.sideEffects,
    this.dosageInstructions,
  });

  @override
  String toString() {
    return 'UsageInstructions(indications: $indications, sideEffects: $sideEffects, dosageInstructions: $dosageInstructions)';
  }

  factory UsageInstructions.fromMap(Map<String, dynamic> data) {
    return UsageInstructions(
      indications: data['indications'] as String?,
      sideEffects: data['sideEffects'] as String?,
      dosageInstructions: data['dosageInstructions'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'indications': indications,
    'sideEffects': sideEffects,
    'dosageInstructions': dosageInstructions,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UsageInstructions].
  factory UsageInstructions.fromJson(String data) {
    return UsageInstructions.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UsageInstructions] to a JSON string.
  String toJson() => json.encode(toMap());

  UsageInstructions copyWith({
    String? indications,
    String? sideEffects,
    String? dosageInstructions,
  }) {
    return UsageInstructions(
      indications: indications ?? this.indications,
      sideEffects: sideEffects ?? this.sideEffects,
      dosageInstructions: dosageInstructions ?? this.dosageInstructions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UsageInstructions) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      indications.hashCode ^ sideEffects.hashCode ^ dosageInstructions.hashCode;
}
