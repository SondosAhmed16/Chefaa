import 'dart:convert';

import 'package:collection/collection.dart';

class Doctor {
  String? id;
  String? name;
  String? specialization;
  double? rating;

  Doctor({this.id, this.name, this.specialization, this.rating});

  @override
  String toString() {
    return 'Doctor(id: $id, name: $name, specialization: $specialization, rating: $rating)';
  }

  factory Doctor.fromMap(Map<String, dynamic> data) => Doctor(
    id: data['_id'] as String?,
    name: data['name'] as String?,
    specialization: data['specialization'] as String?,
    rating: (data['rating'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'name': name,
    'specialization': specialization,
    'rating': rating,
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

  Doctor copyWith({
    String? id,
    String? name,
    String? specialization,
    double? rating,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      rating: rating ?? this.rating ,
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
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ specialization.hashCode ^ rating.hashCode;
}
