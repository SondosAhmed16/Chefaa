class ApiEndpoints {
  static const String baseUrl = "https://shefaa-backend.vercel.app/api/";
  static const String login = "auth/login";
  static const String forgetPass = 'auth/forgot-password';
  static const String verifyCode = 'auth/verify-reset-code';
  static const String resetPass = "auth/reset-password";
  static const String register = "auth/register";
  static const String update_info = "patient/profile";
  static const String getProfilePat = "patient/profile";
  static const String updateBasicInfo = "patient/profile/basic-info";
  static const String updateMedInfo = "patient/profile/medical-info";
  static const String getMedication = "patient/my-medications";
  static const String addMedication = "patient/medications";
  static String confirmMedication(String medicationId) =>
      "patient/medications/$medicationId/confirm";

  static String deleteMedication(String medicationId) =>
      "patient/medications/$medicationId";

  static String updateMedication(String medicationId) =>
      "patient/medications/$medicationId";
}

class ApiKey {
  static const String errorMessage = "message";
  static const String accessToken = 'accessToken';
  static const String refreshToken = "refreshToken";
  static const String user = 'user';
  static const String name = 'name';
  static const String id = 'id';
  static const String role = 'role';
  static const String message = 'message';
  static const String membership = 'membership';
  static const String specialization = 'specialization';
  static const String medicalLicence = 'medicalLicence';
  static const String commercialRegisterNumber = 'commercialRegisterNumber';
  static const String medicalDirectorName = "medicalDirectorName";
  static const String directorProfessionalId = "directorProfessionalId";
  static const String facilityType = "facilityType";
  static const String age = "age";
  static const String gender = "gender";
  static const String height = "height";
  static const String weight = "weight";
  static const String bloodType = "bloodType";
}
