import 'dart:convert';

import 'package:collection/collection.dart';

import 'clinic.dart';

class Model {
  String? id;
  String? name;
  String? specialization;
  int? age;
  int? yearsOfExperience;
  String? image;
  String? about;
  List<String>? degrees;
  String? gender;
  int? rating;
  List<String>? prePaymentNumbers;
  int? clinicConsultationPrice;
  List<dynamic>? reviews;
  List<Clinic>? clinics;

  Model({
    this.id,
    this.name,
    this.specialization,
    this.age,
    this.yearsOfExperience,
    this.image,
    this.about,
    this.degrees,
    this.gender,
    this.rating,
    this.prePaymentNumbers,
    this.clinicConsultationPrice,
    this.reviews,
    this.clinics,
  });

  @override
  String toString() {
    return 'Model(id: $id, name: $name, specialization: $specialization, age: $age, yearsOfExperience: $yearsOfExperience, image: $image, about: $about, degrees: $degrees, gender: $gender, rating: $rating, prePaymentNumbers: $prePaymentNumbers, clinicConsultationPrice: $clinicConsultationPrice, reviews: $reviews, clinics: $clinics)';
  }

  factory Model.fromMap(Map<String, dynamic> data) => Model(
    id: data['_id'] as String?,
    name: data['name'] as String?,
    specialization: data['specialization'] as String?,
    age: data['age'] as int?,
    yearsOfExperience: data['yearsOfExperience'] as int?,
    image: data['image'] as String?,
    about: data['about'] as String?,
    degrees: (data['degrees'] as List?)?.cast<String>(),
    prePaymentNumbers: (data['prePaymentNumbers'] as List?)?.cast<String>(),
    gender: data['gender'] as String?,
    rating: data['rating'] as int?,
    clinicConsultationPrice: data['clinicConsultationPrice'] as int?,
    reviews: data['reviews'] as List<dynamic>?,
    clinics: (data['clinics'] as List<dynamic>?)
        ?.map((e) => Clinic.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'name': name,
    'specialization': specialization,
    'age': age,
    'yearsOfExperience': yearsOfExperience,
    'image': image,
    'about': about,
    'degrees': degrees,
    'gender': gender,
    'rating': rating,
    'prePaymentNumbers': prePaymentNumbers,
    'clinicConsultationPrice': clinicConsultationPrice,
    'reviews': reviews,
    'clinics': clinics?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Model].
  factory Model.fromJson(String data) {
    return Model.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Model] to a JSON string.
  String toJson() => json.encode(toMap());

  Model copyWith({
    String? id,
    String? name,
    String? specialization,
    int? age,
    int? yearsOfExperience,
    String? image,
    String? about,
    List<String>? degrees,
    String? gender,
    int? rating,
    List<String>? prePaymentNumbers,
    int? clinicConsultationPrice,
    List<dynamic>? reviews,
    List<Clinic>? clinics,
  }) {
    return Model(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      age: age ?? this.age,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      image: image ?? this.image,
      about: about ?? this.about,
      degrees: degrees ?? this.degrees,
      gender: gender ?? this.gender,
      rating: rating ?? this.rating,
      prePaymentNumbers: prePaymentNumbers ?? this.prePaymentNumbers,
      clinicConsultationPrice:
          clinicConsultationPrice ?? this.clinicConsultationPrice,
      reviews: reviews ?? this.reviews,
      clinics: clinics ?? this.clinics,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Model) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      specialization.hashCode ^
      age.hashCode ^
      yearsOfExperience.hashCode ^
      image.hashCode ^
      about.hashCode ^
      degrees.hashCode ^
      gender.hashCode ^
      rating.hashCode ^
      prePaymentNumbers.hashCode ^
      clinicConsultationPrice.hashCode ^
      reviews.hashCode ^
      clinics.hashCode;
}
