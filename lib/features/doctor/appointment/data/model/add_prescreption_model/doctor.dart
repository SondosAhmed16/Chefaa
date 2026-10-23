import 'dart:convert';

import 'package:collection/collection.dart';

class Doctor {
  String? id;
  String? specialization;

  Doctor({this.id, this.specialization});

  @override
  String toString() => 'Doctor(id: $id, specialization: $specialization)';

  factory Doctor.fromMap(Map<String, dynamic> data) => Doctor(
    id: data['_id'] as String?,
    specialization: data['specialization'] as String?,
  );

  Map<String, dynamic> toMap() => {'_id': id, 'specialization': specialization};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Doctor].
  factory Doctor.fromJson(String data) {
    return Doctor.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Doctor] to a JSON string.
  String toJson() => json.encode(toMap());

  Doctor copyWith({String? id, String? specialization}) {
    return Doctor(
      id: id ?? this.id,
      specialization: specialization ?? this.specialization,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Doctor) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ specialization.hashCode;
}
