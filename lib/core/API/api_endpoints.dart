class ApiEndpoints {
  static const String baseUrl = "https://shefaa-backend.vercel.app/api/";
  static const String login = "auth/login";
  static const String forgetPass = 'auth/forgot-password';
  static const String verifyCode = 'auth/verify-reset-code';
  static const String resetPass = "auth/reset-password";
  static const String register = "auth/register";
  static const String update_info = "patient/profile";
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
}
