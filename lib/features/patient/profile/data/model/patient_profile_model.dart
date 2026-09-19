import 'package:chefaa/features/patient/profile/domain/entity/profile_patient_entity.dart';

class PatientProfileModel extends ProfilePatientEntity {
  PatientProfileModel({
    super.userName,
    super.userAddress,
    super.age,
    super.gender,
    super.height,
    super.weight,
    super.bloodType,
    super.allergiesList,
    super.chronicConditionsList,
  });

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['updatedData'] ?? json['data'] ?? json;

    String? extractedName;
    if (data['userId'] is Map) {
      extractedName = data['userId']['name'];
    } else {
      extractedName = data['name'] ?? data['userName'];
    }

    return PatientProfileModel(
      userName: extractedName,

      age: data['age'],
      gender: data['gender'],
      height: data['height'],
      weight: data['weight'],
      bloodType: data['bloodType'],

      allergiesList: data['allergies'] != null
          ? List<String>.from(data['allergies'])
          : (data['allergiesList'] != null
                ? List<String>.from(data['allergiesList'])
                : null),

      chronicConditionsList: data['chronicConditions'] != null
          ? List<String>.from(data['chronicConditions'])
          : (data['chronicConditionsList'] != null
                ? List<String>.from(data['chronicConditionsList'])
                : null),
    );
  }

  Map<String, dynamic> toBasicInfoJson() {
    return {
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
    };
  }

  Map<String, dynamic> toMedicalInfoJson() {
    return {
      if (bloodType != null) 'bloodType': bloodType,
      if (allergiesList != null) 'allergies': allergiesList,
      if (chronicConditionsList != null)
        'chronicConditions': chronicConditionsList,
    };
  }
}
