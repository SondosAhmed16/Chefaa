import 'dart:convert';

import 'package:collection/collection.dart';

import 'user_id.dart';

class Doctor {
  String? id;
  UserId? userId;
  String? specialization;

  Doctor({this.id, this.userId, this.specialization});

  @override
  String toString() {
    return 'Doctor(id: $id, userId: $userId, specialization: $specialization)';
  }

  factory Doctor.fromMap(Map<String, dynamic> data) => Doctor(
    id: data['_id'] as String?,
    userId: data['userId'] == null
        ? null
        : UserId.fromMap(data['userId'] as Map<String, dynamic>),
    specialization: data['specialization'] as String?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'userId': userId?.toMap(),
    'specialization': specialization,
  };

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

  Doctor copyWith({String? id, UserId? userId, String? specialization}) {
    return Doctor(
      id: id ?? this.id,
      userId: userId ?? this.userId,
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
  int get hashCode => id.hashCode ^ userId.hashCode ^ specialization.hashCode;
}
