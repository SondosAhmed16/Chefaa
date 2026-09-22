import 'package:chefaa/core/shared%20classes/user_entity.dart';

class RegisterPatientResponseEntity {
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  RegisterPatientResponseEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.message,
  });
}
