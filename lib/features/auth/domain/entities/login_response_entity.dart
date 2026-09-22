import 'package:chefaa/core/shared%20classes/user_entity.dart';

class LoginResponseEntity {
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  LoginResponseEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}
