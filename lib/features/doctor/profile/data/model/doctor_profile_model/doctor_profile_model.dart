import 'dart:convert';

import 'package:collection/collection.dart';

import 'clinic.dart';

class DoctorProfileModel {
  String? id;
  String? specialization;
  int? age;
  int? yearsOfExperience;
  String? image;
  String? about;
  List<String>? degrees;
  String? gender;
  double? rating;
  String? paymentOption;
  List<String>? prePaymentNumbers;
  int? clinicConsultationPrice;
  List<Clinic>? clinics;
  List<dynamic>? reviews;
  String? contactNumber;
  String? membershipPdf;
  String? name;
  String? email;

  DoctorProfileModel({
    this.id,
    this.specialization,
    this.age,
    this.yearsOfExperience,
    this.image,
    this.about,
    this.degrees,
    this.gender,
    this.rating,
    this.paymentOption,
    this.prePaymentNumbers,
    this.clinicConsultationPrice,
    this.clinics,
    this.reviews,
    this.contactNumber,
    this.membershipPdf,
    this.name,
    this.email,
  });

  @override
  String toString() {
    return 'DoctorProfileModel(id: $id, specialization: $specialization, age: $age, yearsOfExperience: $yearsOfExperience, image: $image, about: $about, degrees: $degrees, gender: $gender, rating: $rating, paymentOption: $paymentOption, prePaymentNumbers: $prePaymentNumbers, clinicConsultationPrice: $clinicConsultationPrice, clinics: $clinics, reviews: $reviews, contactNumber: $contactNumber, membershipPdf: $membershipPdf, name: $name, email: $email)';
  }

  factory DoctorProfileModel.fromMap(Map<String, dynamic> data) {
    return DoctorProfileModel(
      id: data['_id'] as String?,
      specialization: data['specialization'] as String?,
      age: data['age'] as int?,
      yearsOfExperience: data['yearsOfExperience'] as int?,
      image: data['image'] as String?,
      about: data['about'] as String?,
      degrees: (data['degrees'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
      gender: data['gender'] as String?,
      rating: (data['rating'] as num?)?.toDouble(),
      paymentOption: data['paymentOption'] as String?,
      prePaymentNumbers: (data['prePaymentNumbers'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
      clinicConsultationPrice: data['clinicConsultationPrice'] as int?,
      clinics: (data['clinics'] as List<dynamic>?)
          ?.map((e) => Clinic.fromMap(e as Map<String, dynamic>))
          .toList(),
      reviews: data['reviews'] as List<dynamic>?,
      contactNumber: data['contactNumber'] as String?,
      membershipPdf: data['membershipPdf'] as String?,
      name: data['name'] as String?,
      email: data['email'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    '_id': id,
    'specialization': specialization,
    'age': age,
    'yearsOfExperience': yearsOfExperience,
    'image': image,
    'about': about,
    'degrees': degrees,
    'gender': gender,
    'rating': rating,
    'paymentOption': paymentOption,
    'prePaymentNumbers': prePaymentNumbers,
    'clinicConsultationPrice': clinicConsultationPrice,
    'clinics': clinics?.map((e) => e.toMap()).toList(),
    'reviews': reviews,
    'contactNumber': contactNumber,
    'membershipPdf': membershipPdf,
    'name': name,
    'email': email,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DoctorProfileModel].
  factory DoctorProfileModel.fromJson(String data) {
    return DoctorProfileModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [DoctorProfileModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DoctorProfileModel copyWith({
    String? id,
    String? specialization,
    int? age,
    int? yearsOfExperience,
    String? image,
    String? about,
    List<String>? degrees,
    String? gender,
    double? rating,
    String? paymentOption,
    List<String>? prePaymentNumbers,
    int? clinicConsultationPrice,
    List<Clinic>? clinics,
    List<dynamic>? reviews,
    String? contactNumber,
    String? membershipPdf,
    String? name,
    String? email,
  }) {
    return DoctorProfileModel(
      id: id ?? this.id,
      specialization: specialization ?? this.specialization,
      age: age ?? this.age,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      image: image ?? this.image,
      about: about ?? this.about,
      degrees: degrees ?? this.degrees,
      gender: gender ?? this.gender,
      rating: rating ?? this.rating,
      paymentOption: paymentOption ?? this.paymentOption,
      prePaymentNumbers: prePaymentNumbers ?? this.prePaymentNumbers,
      clinicConsultationPrice:
          clinicConsultationPrice ?? this.clinicConsultationPrice,
      clinics: clinics ?? this.clinics,
      reviews: reviews ?? this.reviews,
      contactNumber: contactNumber ?? this.contactNumber,
      membershipPdf: membershipPdf ?? this.membershipPdf,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DoctorProfileModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      specialization.hashCode ^
      age.hashCode ^
      yearsOfExperience.hashCode ^
      image.hashCode ^
      about.hashCode ^
      degrees.hashCode ^
      gender.hashCode ^
      rating.hashCode ^
      paymentOption.hashCode ^
      prePaymentNumbers.hashCode ^
      clinicConsultationPrice.hashCode ^
      clinics.hashCode ^
      reviews.hashCode ^
      contactNumber.hashCode ^
      membershipPdf.hashCode ^
      name.hashCode ^
      email.hashCode;
}
