import 'dart:convert';

import 'package:collection/collection.dart';

import 'address.dart';
import 'ai_visibility.dart';
import 'settings.dart';
import 'working_hours.dart';

class ProfileData {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? facilityType;
  WorkingHours? workingHours;
  int? servicesCount;
  List<String>? paymentMethods;
  String? commercialRegisterNumber;
  String? medicalLicencePdf;
  String? medicalDirectorName;
  String? directorProfessionalId;
  List<Address>? addresses;
  AiVisibility? aiVisibility;
  Settings? settings;

  ProfileData({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.facilityType,
    this.workingHours,
    this.servicesCount,
    this.paymentMethods,
    this.commercialRegisterNumber,
    this.medicalLicencePdf,
    this.medicalDirectorName,
    this.directorProfessionalId,
    this.addresses,
    this.aiVisibility,
    this.settings,
  });

  @override
  String toString() {
    return 'ProfileData(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, facilityType: $facilityType, workingHours: $workingHours, servicesCount: $servicesCount, paymentMethods: $paymentMethods, commercialRegisterNumber: $commercialRegisterNumber, medicalLicencePdf: $medicalLicencePdf, medicalDirectorName: $medicalDirectorName, directorProfessionalId: $directorProfessionalId, addresses: $addresses, aiVisibility: $aiVisibility, settings: $settings)';
  }

  factory ProfileData.fromMap(Map<String, dynamic> data) => ProfileData(
    id: data['id'] as String?,
    name: data['name'] as String?,
    phoneNumber: data['phoneNumber'] as String?,
    email: data['email'] as String?,
    facilityType: data['facilityType'] as String?,
    workingHours: data['workingHours'] == null
        ? null
        : WorkingHours.fromMap(data['workingHours'] as Map<String, dynamic>),
    servicesCount: data['servicesCount'] as int?,
    paymentMethods: (data['paymentMethods'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    commercialRegisterNumber: data['commercialRegisterNumber'] as String?,
    medicalLicencePdf: data['medicalLicencePdf'] as String?,
    medicalDirectorName: data['medicalDirectorName'] as String?,
    directorProfessionalId: data['directorProfessionalId'] as String?,
    addresses: (data['addresses'] as List<dynamic>?)
        ?.map((e) => Address.fromMap(e as Map<String, dynamic>))
        .toList(),
    aiVisibility: data['aiVisibility'] == null
        ? null
        : AiVisibility.fromMap(data['aiVisibility'] as Map<String, dynamic>),
    settings: data['settings'] == null
        ? null
        : Settings.fromMap(data['settings'] as Map<String, dynamic>),
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'email': email,
    'facilityType': facilityType,
    'workingHours': workingHours?.toMap(),
    'servicesCount': servicesCount,
    'paymentMethods': paymentMethods,
    'commercialRegisterNumber': commercialRegisterNumber,
    'medicalLicencePdf': medicalLicencePdf,
    'medicalDirectorName': medicalDirectorName,
    'directorProfessionalId': directorProfessionalId,
    'addresses': addresses?.map((e) => e.toMap()).toList(),
    'aiVisibility': aiVisibility?.toMap(),
    'settings': settings?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProfileData].
  factory ProfileData.fromJson(String data) {
    return ProfileData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProfileData] to a JSON string.
  String toJson() => json.encode(toMap());

  ProfileData copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? facilityType,
    WorkingHours? workingHours,
    int? servicesCount,
    List<String>? paymentMethods,
    String? commercialRegisterNumber,
    String? medicalLicencePdf,
    String? medicalDirectorName,
    String? directorProfessionalId,
    List<Address>? addresses,
    AiVisibility? aiVisibility,
    Settings? settings,
  }) {
    return ProfileData(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      facilityType: facilityType ?? this.facilityType,
      workingHours: workingHours ?? this.workingHours,
      servicesCount: servicesCount ?? this.servicesCount,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      commercialRegisterNumber:
          commercialRegisterNumber ?? this.commercialRegisterNumber,
      medicalLicencePdf: medicalLicencePdf ?? this.medicalLicencePdf,
      medicalDirectorName: medicalDirectorName ?? this.medicalDirectorName,
      directorProfessionalId:
          directorProfessionalId ?? this.directorProfessionalId,
      addresses: addresses ?? this.addresses,
      aiVisibility: aiVisibility ?? this.aiVisibility,
      settings: settings ?? this.settings,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProfileData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      facilityType.hashCode ^
      workingHours.hashCode ^
      servicesCount.hashCode ^
      paymentMethods.hashCode ^
      commercialRegisterNumber.hashCode ^
      medicalLicencePdf.hashCode ^
      medicalDirectorName.hashCode ^
      directorProfessionalId.hashCode ^
      addresses.hashCode ^
      aiVisibility.hashCode ^
      settings.hashCode;
}
