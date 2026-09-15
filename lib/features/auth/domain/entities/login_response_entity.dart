class LoginResponseEntity {
final String accessToken;
final String refreshToken;
final UserEntity user;

  LoginResponseEntity({required this.accessToken, required this.refreshToken, required this.user});


}

class UserEntity{
  final String name;
  final String id;
  final String role;

  UserEntity({required this.name, required this.id, required this.role});
}