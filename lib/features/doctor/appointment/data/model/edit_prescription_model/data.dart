import 'dart:convert';

import 'package:chefaa/features/doctor/appointment/data/model/add_prescreption_model/appointment.dart';
import 'package:collection/collection.dart';

import '../add_prescreption_model/doctor.dart';
import '../add_prescreption_model/patient.dart';
import 'medicine.dart';

class Data {
  String? id;
  Appointment? appointment;
  Doctor? doctor;
  Patient? patient;
  String? diagnosis;
  List<Medicine>? medicines;
  List<String>? labTests;
  List<String>? imaging;
  String? nextVisit;
  String? notes;
  List<dynamic>? suggestedPharmacies;
  List<dynamic>? attachedFiles;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.appointment,
    this.doctor,
    this.patient,
    this.diagnosis,
    this.medicines,
    this.labTests,
    this.imaging,
    this.nextVisit,
    this.notes,
    this.suggestedPharmacies,
    this.attachedFiles,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Data(id: $id, appointment: $appointment, doctor: $doctor, patient: $patient, diagnosis: $diagnosis, medicines: $medicines, labTests: $labTests, imaging: $imaging, nextVisit: $nextVisit, notes: $notes, suggestedPharmacies: $suggestedPharmacies, attachedFiles: $attachedFiles, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    id: data['_id'] as String?,
    appointment: data['appointment'] == null
        ? null
        : Appointment.fromMap(data['appointment'] as Map<String, dynamic>),
    doctor: data['doctor'] == null
        ? null
        : Doctor.fromMap(data['doctor'] as Map<String, dynamic>),
    patient: data['patient'] == null
        ? null
        : Patient.fromMap(data['patient'] as Map<String, dynamic>),
    diagnosis: data['diagnosis'] as String?,
    medicines: (data['medicines'] as List<dynamic>?)
        ?.map((e) => Medicine.fromMap(e as Map<String, dynamic>))
        .toList(),
    labTests: data['labTests'] == null
        ? null
        : List<String>.from(
            (data['labTests'] as List).map((e) => e.toString()),
          ),
    imaging: data['imaging'] == null
        ? null
        : List<String>.from((data['imaging'] as List).map((e) => e.toString())),
    nextVisit: data['nextVisit'] as String?,
    notes: data['notes'] as String?,
    suggestedPharmacies: data['suggestedPharmacies'] as List<dynamic>?,
    attachedFiles: data['attachedFiles'] as List<dynamic>?,
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
    updatedAt: data['updatedAt'] == null
        ? null
        : DateTime.parse(data['updatedAt'] as String),
    v: data['__v'] as int?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'appointment': appointment?.toMap(),
    'doctor': doctor?.toMap(),
    'patient': patient?.toMap(),
    'diagnosis': diagnosis,
    'medicines': medicines?.map((e) => e.toMap()).toList(),
    'labTests': labTests,
    'imaging': imaging,
    'nextVisit': nextVisit,
    'notes': notes,
    'suggestedPharmacies': suggestedPharmacies,
    'attachedFiles': attachedFiles,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    String? id,
    Appointment? appointment,
    Doctor? doctor,
    Patient? patient,
    String? diagnosis,
    List<Medicine>? medicines,
    List<String>? labTests,
    List<String>? imaging,
    String? nextVisit,
    String? notes,
    List<dynamic>? suggestedPharmacies,
    List<dynamic>? attachedFiles,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Data(
      id: id ?? this.id,
      appointment: appointment ?? this.appointment,
      doctor: doctor ?? this.doctor,
      patient: patient ?? this.patient,
      diagnosis: diagnosis ?? this.diagnosis,
      medicines: medicines ?? this.medicines,
      labTests: labTests ?? this.labTests,
      imaging: imaging ?? this.imaging,
      nextVisit: nextVisit ?? this.nextVisit,
      notes: notes ?? this.notes,
      suggestedPharmacies: suggestedPharmacies ?? this.suggestedPharmacies,
      attachedFiles: attachedFiles ?? this.attachedFiles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      appointment.hashCode ^
      doctor.hashCode ^
      patient.hashCode ^
      diagnosis.hashCode ^
      medicines.hashCode ^
      labTests.hashCode ^
      imaging.hashCode ^
      nextVisit.hashCode ^
      notes.hashCode ^
      suggestedPharmacies.hashCode ^
      attachedFiles.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
