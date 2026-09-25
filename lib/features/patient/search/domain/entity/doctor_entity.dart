class DoctorEntity {
  final String id;
  final String name;
  final String specialization;
  final String? profilePicture;
  final String? gender;
  final String? bio;

  DoctorEntity({
    required this.id,
    required this.name,
    required this.specialization,
    this.profilePicture,
    this.gender,
    this.bio,
  });
}