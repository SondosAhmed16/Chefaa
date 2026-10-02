class DoctorEntity {
  final String id;
  final String name;
  final String specialization;
  final String? profilePicture;
  final String? gender;
  final String? bio;
  final double? rating;
  final int? ratingCount;
  DoctorEntity({
    this.rating,
    this.ratingCount,
    required this.id,
    required this.name,
    required this.specialization,
    this.profilePicture,
    this.gender,
    this.bio,
  });
}
