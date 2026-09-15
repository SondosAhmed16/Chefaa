import 'dart:convert';
import 'package:chefaa/features/auth/data/model/login_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/auth/domain/entities/login_response_entity.dart';

class StorageServices {
  static String? token;
  static String? role;
  static UserEntity? user;

  static const _storage = FlutterSecureStorage(
    // ignore: deprecated_member_use
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<void> saveToken(String value) async {
    token = value;
    await _storage.write(key: ApiKey.accessToken, value: value);
  }

  static Future<String?> getToken() async {
    final value = await _storage.read(key: ApiKey.accessToken);
    token = value;
    return value;
  }

  static Future<void> saveUser(UserEntity value) async {
    user = value;
    
    final userModel = UserModel(
      name: value.name,
      id: value.id,
      role: value.role,
    );

    final jsonString = jsonEncode(userModel.toJson());
    await _storage.write(key: ApiKey.user, value: jsonString);
  }

  static Future<UserEntity?> getUser() async {
    final jsonString = await _storage.read(key: ApiKey.user);
    if (jsonString == null) return null;

    final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
    
    final userData = UserModel.fromJson(userMap);
    user = userData;
    return userData;
  }

  static Future<void> saveRole(String value) async {
    role = value;
    await _storage.write(key: ApiKey.role, value: value);
  }

  static Future<String?> getRole() async {
    final value = await _storage.read(key: ApiKey.role);
    role = value;
    return value;
  }

  static Future<void> logout() async {
    token = null;
    user = null;
    role = null;
    await _storage.delete(key: ApiKey.accessToken);
    await _storage.delete(key: ApiKey.user);
    await _storage.delete(key: ApiKey.role);
  }
}