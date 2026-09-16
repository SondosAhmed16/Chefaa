class ApiEndpoints {
  static const String baseUrl = "https://shefaa-backend.vercel.app/api/";
  static const String login = "auth/login";
  static const String forgetPass = 'auth/forgot-password';
  static const String verifyCode = 'auth/verify-reset-code';
  static const String resetPass = "auth/reset-password";
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
}
