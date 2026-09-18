import 'package:chefaa/core/shared%20classes/user_entity.dart';

class RegisterPharmacyResponseEntity {
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserEntity? user;

  RegisterPharmacyResponseEntity({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}
