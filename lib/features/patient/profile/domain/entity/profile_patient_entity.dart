class ProfilePatientEntity {
  final String? userName;
  final String? userAddress;
  final num? age;
  final String? gender;
  final num? height;
  final num? weight;
  final String? bloodType;
  final List<String>? allergiesList;
  final List<String>? chronicConditionsList;

  ProfilePatientEntity({
    this.userName,
    this.userAddress,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bloodType,
    this.allergiesList,
    this.chronicConditionsList,
  });
ProfilePatientEntity copyWith({
    String? userName,
    num? age,
    String? gender,
    num? height,
    num? weight,
    String? bloodType,
    List<String>? allergiesList,
    List<String>? chronicConditionsList,
  }) {
    return ProfilePatientEntity(
      userName: userName ?? this.userName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bloodType: bloodType ?? this.bloodType,
      allergiesList: allergiesList ?? this.allergiesList,
      chronicConditionsList: chronicConditionsList ?? this.chronicConditionsList,
    );
  }
}