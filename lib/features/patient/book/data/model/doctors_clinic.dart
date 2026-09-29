import 'dart:convert';

import 'package:collection/collection.dart';

import 'clinic.dart';
import 'doctor.dart';

class DoctorsClinic {
  bool? success;
  Doctor? doctor;
  int? totalClinics;
  List<Clinic>? clinics;

  DoctorsClinic({this.success, this.doctor, this.totalClinics, this.clinics});

  @override
  String toString() {
    return 'DoctorsClinic(success: $success, doctor: $doctor, totalClinics: $totalClinics, clinics: $clinics)';
  }

  factory DoctorsClinic.fromMap(Map<String, dynamic> data) => DoctorsClinic(
    success: data['success'] as bool?,
    doctor: data['doctor'] == null
        ? null
        : Doctor.fromMap(data['doctor'] as Map<String, dynamic>),
    totalClinics: data['totalClinics'] as int?,
    clinics: (data['clinics'] as List<dynamic>?)
        ?.map((e) => Clinic.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'success': success,
    'doctor': doctor?.toMap(),
    'totalClinics': totalClinics,
    'clinics': clinics?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DoctorsClinic].
  factory DoctorsClinic.fromJson(String data) {
    return DoctorsClinic.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DoctorsClinic] to a JSON string.
  String toJson() => json.encode(toMap());

  DoctorsClinic copyWith({
    bool? success,
    Doctor? doctor,
    int? totalClinics,
    List<Clinic>? clinics,
  }) {
    return DoctorsClinic(
      success: success ?? this.success,
      doctor: doctor ?? this.doctor,
      totalClinics: totalClinics ?? this.totalClinics,
      clinics: clinics ?? this.clinics,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DoctorsClinic) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^
      doctor.hashCode ^
      totalClinics.hashCode ^
      clinics.hashCode;
}
