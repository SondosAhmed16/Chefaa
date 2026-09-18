class PatientInfoResEntity {
  final String message;
  final PatientAllInfoEntity patient;

  PatientInfoResEntity({required this.message, required this.patient});
}

class PatientAllInfoEntity {
  final String id;
  final String userId;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String bloodType;
  final List<String> allergies;
  final List<String> chronicConditions;
  final AddressEntity? address;

  PatientAllInfoEntity({
    required this.id,
    required this.userId,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.allergies,
    required this.chronicConditions,
    required this.address,
  });
}

class AddressEntity {
  final String? addressText;
  final List<double>? coordinates;

  AddressEntity({this.addressText, this.coordinates});
}
