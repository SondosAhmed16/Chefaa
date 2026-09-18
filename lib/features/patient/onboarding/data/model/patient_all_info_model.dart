import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/onboarding/domain/entity/patient_all_info_entity.dart';

class PatientAllInfoRes extends PatientInfoResEntity {
  PatientAllInfoRes({required super.message, required super.patient});

  factory PatientAllInfoRes.fromJson(Map<String, dynamic> json) {
    return PatientAllInfoRes(
      message: json[ApiKey.message] ?? '',
      patient: PatientAllInfoModel.fromJson(json['patient']),
    );
  }
}

class PatientAllInfoModel extends PatientAllInfoEntity {
  PatientAllInfoModel({
    required super.id,
    required super.userId,
    required super.age,
    required super.gender,
    required super.height,
    required super.weight,
    required super.bloodType,
    required super.allergies,
    required super.chronicConditions,
    required super.address,
  });

  factory PatientAllInfoModel.fromJson(Map<String, dynamic> json) {
    return PatientAllInfoModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0,
      gender: json['gender'] ?? '',
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      bloodType: json['bloodType'] ?? '',
      allergies: json['allergies'] != null
          ? List<String>.from(json['allergies'])
          : [],
      chronicConditions: json['chronicConditions'] != null
          ? List<String>.from(json['chronicConditions'])
          : [],
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
    );
  }
}

class AddressModel extends AddressEntity {
  AddressModel({super.addressText, super.coordinates});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressText: json['addressText'],
      coordinates:
          json['location'] != null && json['location']['coordinates'] != null
          ? List<double>.from(
              (json['location']['coordinates'] as List).map(
                (e) => (e as num).toDouble(),
              ),
            )
          : null,
    );
  }
}
