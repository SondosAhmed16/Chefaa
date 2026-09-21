class AppointmentEntity {
  final String id;
  final String doctorName;
  final String doctorSpecialty;
  final String? doctorImage;
  final String dateTime;
  final String status;

  AppointmentEntity({
    required this.id,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImage,
    required this.dateTime,
    required this.status,
  });
}
