import 'dart:convert';

import 'package:collection/collection.dart';

import 'address.dart';
import 'user_id.dart';

class Patient {
  Address? address;
  String? id;
  UserId? userId;
  int? age;
  String? gender;
  int? height;
  int? weight;
  String? bloodType;
  List<String>? allergies;
  List<String>? chronicConditions;
  bool? isBlocked;

  Patient({
    this.address,
    this.id,
    this.userId,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bloodType,
    this.allergies,
    this.chronicConditions,
    this.isBlocked,
  });

  @override
  String toString() {
    return 'Patient(address: $address, id: $id, userId: $userId, age: $age, gender: $gender, height: $height, weight: $weight, bloodType: $bloodType, allergies: $allergies, chronicConditions: $chronicConditions, isBlocked: $isBlocked)';
  }

  factory Patient.fromMap(Map<String, dynamic> data) => Patient(
    address: data['address'] == null
        ? null
        : Address.fromMap(data['address'] as Map<String, dynamic>),
    id: data['_id'] as String?,
    userId: data['userId'] == null
        ? null
        : UserId.fromMap(data['userId'] as Map<String, dynamic>),
    age: data['age'] as int?,
    gender: data['gender'] as String?,
    height: data['height'] as int?,
    weight: data['weight'] as int?,
    bloodType: data['bloodType'] as String?,
    allergies: data['allergies'] != null
        ? (data['allergies'] as List<dynamic>).map((e) => e.toString()).toList()
        : null,
    chronicConditions: data['chronicConditions'] != null
        ? (data['chronicConditions'] as List<dynamic>)
              .map((e) => e.toString())
              .toList()
        : null,
    isBlocked: data['isBlocked'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'address': address?.toMap(),
    '_id': id,
    'userId': userId?.toMap(),
    'age': age,
    'gender': gender,
    'height': height,
    'weight': weight,
    'bloodType': bloodType,
    'allergies': allergies,
    'chronicConditions': chronicConditions,
    'isBlocked': isBlocked,
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

  Patient copyWith({
    Address? address,
    String? id,
    UserId? userId,
    int? age,
    String? gender,
    int? height,
    int? weight,
    String? bloodType,
    List<String>? allergies,
    List<String>? chronicConditions,
    bool? isBlocked,
  }) {
    return Patient(
      address: address ?? this.address,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      isBlocked: isBlocked ?? this.isBlocked,
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
      address.hashCode ^
      id.hashCode ^
      userId.hashCode ^
      age.hashCode ^
      gender.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      bloodType.hashCode ^
      allergies.hashCode ^
      chronicConditions.hashCode ^
      isBlocked.hashCode;
}
