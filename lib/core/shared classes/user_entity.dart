import 'package:chefaa/core/API/api_endpoints.dart';

class UserEntity{
  final String name;
  final String id;
  final String role;

  UserEntity({required this.name, required this.id, required this.role});
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