import 'dart:convert';

import 'package:collection/collection.dart';

import 'clinic.dart';
import 'doctor.dart';
import 'patient.dart';

class Datum {
  String? id;
  Patient? patient;
  Doctor? doctor;
  Clinic? clinic;
  dynamic prescription;
  DateTime? date;
  String? timeChosed;
  String? slotStart;
  String? slotEnd;
  bool? isFollowUp;
  String? paymentStatus;
  String? paymentOption;
  String? status;
  dynamic paidAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.patient,
    this.doctor,
    this.clinic,
    this.prescription,
    this.date,
    this.timeChosed,
    this.slotStart,
    this.slotEnd,
    this.isFollowUp,
    this.paymentStatus,
    this.paymentOption,
    this.status,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Datum(id: $id, patient: $patient, doctor: $doctor, clinic: $clinic, prescription: $prescription, date: $date, timeChosed: $timeChosed, slotStart: $slotStart, slotEnd: $slotEnd, isFollowUp: $isFollowUp, paymentStatus: $paymentStatus, paymentOption: $paymentOption, status: $status, paidAt: $paidAt, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
    id: data['_id'] as String?,
    patient: data['patient'] == null
        ? null
        : Patient.fromMap(data['patient'] as Map<String, dynamic>),
    doctor: data['doctor'] == null
        ? null
        : Doctor.fromMap(data['doctor'] as Map<String, dynamic>),
    clinic: data['clinic'] == null
        ? null
        : Clinic.fromMap(data['clinic'] as Map<String, dynamic>),
    prescription: data['prescription'] as dynamic,
    date: data['date'] == null ? null : DateTime.parse(data['date'] as String),
    timeChosed: data['timeChosed'] as String?,
    slotStart: data['slotStart'] as String?,
    slotEnd: data['slotEnd'] as String?,
    isFollowUp: data['isFollowUp'] as bool?,
    paymentStatus: data['paymentStatus'] as String?,
    paymentOption: data['paymentOption'] as String?,
    status: data['status'] as String?,
    paidAt: data['paidAt'] as dynamic,
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
    'patient': patient?.toMap(),
    'doctor': doctor?.toMap(),
    'clinic': clinic?.toMap(),
    'prescription': prescription,
    'date': date?.toIso8601String(),
    'timeChosed': timeChosed,
    'slotStart': slotStart,
    'slotEnd': slotEnd,
    'isFollowUp': isFollowUp,
    'paymentStatus': paymentStatus,
    'paymentOption': paymentOption,
    'status': status,
    'paidAt': paidAt,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    String? id,
    Patient? patient,
    Doctor? doctor,
    Clinic? clinic,
    dynamic prescription,
    DateTime? date,
    String? timeChosed,
    String? slotStart,
    String? slotEnd,
    bool? isFollowUp,
    String? paymentStatus,
    String? paymentOption,
    String? status,
    dynamic paidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Datum(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
      clinic: clinic ?? this.clinic,
      prescription: prescription ?? this.prescription,
      date: date ?? this.date,
      timeChosed: timeChosed ?? this.timeChosed,
      slotStart: slotStart ?? this.slotStart,
      slotEnd: slotEnd ?? this.slotEnd,
      isFollowUp: isFollowUp ?? this.isFollowUp,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentOption: paymentOption ?? this.paymentOption,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Datum) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      patient.hashCode ^
      doctor.hashCode ^
      clinic.hashCode ^
      prescription.hashCode ^
      date.hashCode ^
      timeChosed.hashCode ^
      slotStart.hashCode ^
      slotEnd.hashCode ^
      isFollowUp.hashCode ^
      paymentStatus.hashCode ^
      paymentOption.hashCode ^
      status.hashCode ^
      paidAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
