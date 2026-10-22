import 'dart:convert';

import 'package:collection/collection.dart';

import 'clinics.dart';
import 'doctor.dart';

class ClinicsModel {
  bool? success;
  Doctor? doctor;
  int? totalClinics;
  List<Clinics>? clinics;

  ClinicsModel({this.success, this.doctor, this.totalClinics, this.clinics});

  @override
  String toString() {
    return 'ClinicsModel(success: $success, doctor: $doctor, totalClinics: $totalClinics, clinics: $clinics)';
  }

  factory ClinicsModel.fromMap(Map<String, dynamic> data) => ClinicsModel(
    success: data['success'] as bool?,
    doctor: data['doctor'] == null
        ? null
        : Doctor.fromMap(data['doctor'] as Map<String, dynamic>),
    totalClinics: data['totalClinics'] as int?,
    clinics: (data['clinics'] as List<dynamic>?)
        ?.map((e) => Clinics.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [ClinicsModel].
  factory ClinicsModel.fromJson(String data) {
    return ClinicsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ClinicsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ClinicsModel copyWith({
    bool? success,
    Doctor? doctor,
    int? totalClinics,
    List<Clinics>? clinics,
  }) {
    return ClinicsModel(
      success: success ?? this.success,
      doctor: doctor ?? this.doctor,
      totalClinics: totalClinics ?? this.totalClinics,
      clinics: clinics ?? this.clinics,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ClinicsModel) return false;
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
