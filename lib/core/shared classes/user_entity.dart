import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/auth/data/model/login_response_model.dart';

class UserEntity {
  final String name;
  final String id;
  final String role;

  const UserEntity({required this.name, required this.id, required this.role});

  factory UserEntity.fromLoginResponseModel(LoginResponseModel authResponse) {
    return UserEntity(
      id: authResponse.user?.id?.trim() ?? '',
      name: authResponse.user?.name?.trim() ?? '',
      role: authResponse.user?.role?.trim() ?? '',
    );
  }

  factory UserEntity.empty() => const UserEntity(id: '', name: '', role: '');

  UserEntity copyWith({String? id, String? name, String? role}) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }

  bool get isEmpty => id.isEmpty && name.isEmpty;
}

class UserModel extends UserEntity {
  UserModel({required super.name, required super.id, required super.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[ApiKey.name] ?? '',
      id: json[ApiKey.id] ?? '',
      role: json[ApiKey.role] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKey.name: name, ApiKey.id: id, ApiKey.role: role};
  }
}
