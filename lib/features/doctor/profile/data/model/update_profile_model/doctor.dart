import 'dart:convert';

import 'package:collection/collection.dart';

class Doctor {
  String? id;
  String? userId;
  String? specialization;
  String? contactNumber;
  String? image;
  String? about;
  String? membershipPdf;
  List<String>? degrees;
  List<String>? clinics;
  String? paymentOption;
  List<String>? prePaymentNumbers;
  double? rating;
  int? clinicConsultationPrice;
  List<dynamic>? reviews;
  String? visibilityStatus;
  dynamic hiddenAt;
  dynamic hiddenReason;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? age;
  String? gender;
  int? yearsOfExperience;

  Doctor({
    this.id,
    this.userId,
    this.specialization,
    this.contactNumber,
    this.image,
    this.about,
    this.membershipPdf,
    this.degrees,
    this.clinics,
    this.paymentOption,
    this.prePaymentNumbers,
    this.rating,
    this.clinicConsultationPrice,
    this.reviews,
    this.visibilityStatus,
    this.hiddenAt,
    this.hiddenReason,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.age,
    this.gender,
    this.yearsOfExperience,
  });

  @override
  String toString() {
    return 'Doctor(id: $id, userId: $userId, specialization: $specialization, contactNumber: $contactNumber, image: $image, about: $about, membershipPdf: $membershipPdf, degrees: $degrees, clinics: $clinics, paymentOption: $paymentOption, prePaymentNumbers: $prePaymentNumbers, rating: $rating, clinicConsultationPrice: $clinicConsultationPrice, reviews: $reviews, visibilityStatus: $visibilityStatus, hiddenAt: $hiddenAt, hiddenReason: $hiddenReason, createdAt: $createdAt, updatedAt: $updatedAt, v: $v, age: $age, gender: $gender, yearsOfExperience: $yearsOfExperience)';
  }

  factory Doctor.fromMap(Map<String, dynamic> data) => Doctor(
  id: data['_id'] as String?,
  userId: data['userId'] as String?,
  specialization: data['specialization'] as String?,
  contactNumber: data['contactNumber'] as String?,
  image: data['image'] as String?,
  about: data['about'] as String?,
  membershipPdf: data['membershipPdf'] as String?,
  
  degrees: (data['degrees'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
  clinics: (data['clinics'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
  prePaymentNumbers: (data['prePaymentNumbers'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
  
  paymentOption: data['paymentOption'] as String?,
  rating: (data['rating'] as num?)?.toDouble(),
  clinicConsultationPrice: data['clinicConsultationPrice'] as int?,
  reviews: data['reviews'] as List<dynamic>?,
  visibilityStatus: data['visibilityStatus'] as String?,
  hiddenAt: data['hiddenAt'] as dynamic,
  hiddenReason: data['hiddenReason'] as dynamic,
  createdAt: data['createdAt'] == null ? null : DateTime.parse(data['createdAt'] as String),
  updatedAt: data['updatedAt'] == null ? null : DateTime.parse(data['updatedAt'] as String),
  v: data['__v'] as int?,
  age: data['age'] as int?,
  gender: data['gender'] as String?,
  yearsOfExperience: data['yearsOfExperience'] as int?,
);

  Map<String, dynamic> toMap() => {
    '_id': id,
    'userId': userId,
    'specialization': specialization,
    'contactNumber': contactNumber,
    'image': image,
    'about': about,
    'membershipPdf': membershipPdf,
    'degrees': degrees,
    'clinics': clinics,
    'paymentOption': paymentOption,
    'prePaymentNumbers': prePaymentNumbers,
    'rating': rating,
    'clinicConsultationPrice': clinicConsultationPrice,
    'reviews': reviews,
    'visibilityStatus': visibilityStatus,
    'hiddenAt': hiddenAt,
    'hiddenReason': hiddenReason,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
    'age': age,
    'gender': gender,
    'yearsOfExperience': yearsOfExperience,
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
    String? userId,
    String? specialization,
    String? contactNumber,
    String? image,
    String? about,
    String? membershipPdf,
    List<String>? degrees,
    List<String>? clinics,
    String? paymentOption,
    List<String>? prePaymentNumbers,
    double? rating,
    int? clinicConsultationPrice,
    List<dynamic>? reviews,
    String? visibilityStatus,
    dynamic hiddenAt,
    dynamic hiddenReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    int? age,
    String? gender,
    int? yearsOfExperience,
  }) {
    return Doctor(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      specialization: specialization ?? this.specialization,
      contactNumber: contactNumber ?? this.contactNumber,
      image: image ?? this.image,
      about: about ?? this.about,
      membershipPdf: membershipPdf ?? this.membershipPdf,
      degrees: degrees ?? this.degrees,
      clinics: clinics ?? this.clinics,
      paymentOption: paymentOption ?? this.paymentOption,
      prePaymentNumbers: prePaymentNumbers ?? this.prePaymentNumbers,
      rating: rating ?? this.rating,
      clinicConsultationPrice:
          clinicConsultationPrice ?? this.clinicConsultationPrice,
      reviews: reviews ?? this.reviews,
      visibilityStatus: visibilityStatus ?? this.visibilityStatus,
      hiddenAt: hiddenAt ?? this.hiddenAt,
      hiddenReason: hiddenReason ?? this.hiddenReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
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
      id.hashCode ^
      userId.hashCode ^
      specialization.hashCode ^
      contactNumber.hashCode ^
      image.hashCode ^
      about.hashCode ^
      membershipPdf.hashCode ^
      degrees.hashCode ^
      clinics.hashCode ^
      paymentOption.hashCode ^
      prePaymentNumbers.hashCode ^
      rating.hashCode ^
      clinicConsultationPrice.hashCode ^
      reviews.hashCode ^
      visibilityStatus.hashCode ^
      hiddenAt.hashCode ^
      hiddenReason.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode ^
      age.hashCode ^
      gender.hashCode ^
      yearsOfExperience.hashCode;
}
