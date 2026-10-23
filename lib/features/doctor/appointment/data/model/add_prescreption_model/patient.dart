import 'dart:convert';

import 'package:collection/collection.dart';

class Patient {
  String? id;
  String? userId;
  int? age;
  String? gender;

  Patient({this.id, this.userId, this.age, this.gender});

  @override
  String toString() {
    return 'Patient(id: $id, userId: $userId, age: $age, gender: $gender)';
  }

  factory Patient.fromMap(Map<String, dynamic> data) => Patient(
    id: data['_id'] as String?,
    userId: data['userId'] as String?,
    age: data['age'] as int?,
    gender: data['gender'] as String?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'userId': userId,
    'age': age,
    'gender': gender,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Patient].
  factory Patient.fromJson(String data) {
    return Patient.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Patient] to a JSON string.
  String toJson() => json.encode(toMap());

  Patient copyWith({String? id, String? userId, int? age, String? gender}) {
    return Patient(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Patient) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ age.hashCode ^ gender.hashCode;
}
