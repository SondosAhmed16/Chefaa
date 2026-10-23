import 'dart:convert';

import 'package:collection/collection.dart';

class Medicine {
  String? name;
  String? dosage;
  String? frequency;
  String? duration;
  String? instructions;

  Medicine({
    this.name,
    this.dosage,
    this.frequency,
    this.duration,
    this.instructions,
  });

  @override
  String toString() {
    return 'Medicine(name: $name, dosage: $dosage, frequency: $frequency, duration: $duration, instructions: $instructions)';
  }

  factory Medicine.fromMap(Map<String, dynamic> data) => Medicine(
    name: data['name'] as String?,
    dosage: data['dosage'] as String?,
    frequency: data['frequency'] as String?,
    duration: data['duration'] as String?,
    instructions: data['instructions'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'dosage': dosage,
    'frequency': frequency,
    'duration': duration,
    'instructions': instructions,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Medicine].
  factory Medicine.fromJson(String data) {
    return Medicine.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Medicine] to a JSON string.
  String toJson() => json.encode(toMap());

  Medicine copyWith({
    String? name,
    String? dosage,
    String? frequency,
    String? duration,
    String? instructions,
  }) {
    return Medicine(
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Medicine) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      dosage.hashCode ^
      frequency.hashCode ^
      duration.hashCode ^
      instructions.hashCode;
}
