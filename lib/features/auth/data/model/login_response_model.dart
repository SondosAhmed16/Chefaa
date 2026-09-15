import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/auth/domain/entities/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  LoginResponseModel({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json[ApiKey.accessToken],
      refreshToken: json[ApiKey.refreshToken],
      user: UserModel.fromJson(json[ApiKey.user]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.accessToken: accessToken,
      ApiKey.refreshToken: refreshToken,
      ApiKey.user: (user as UserModel).toJson(),
    };
  }
}

class UserModel extends UserEntity {
  UserModel({required super.name, required super.id, required super.role});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[ApiKey.name],
      id: json[ApiKey.id],
      role: json[ApiKey.role],
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKey.name: name, ApiKey.id: id, ApiKey.role: role};
  }
}
