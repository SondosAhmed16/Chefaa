import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/core/shared%20classes/user_entity.dart';
import 'package:chefaa/features/pharmacy/auth/domain/entities/register_pharmacy_response_entity.dart';

class RegisterPharmacyModel extends RegisterPharmacyResponseEntity {
  RegisterPharmacyModel({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
    required super.message,
  });

  factory RegisterPharmacyModel.fromJson(Map<String, dynamic> json) {
    return RegisterPharmacyModel(
      accessToken: json[ApiKey.accessToken] ?? '',
      refreshToken: json[ApiKey.refreshToken] ?? '',
      user: json[ApiKey.user] != null 
          ? UserModel.fromJson(json[ApiKey.user]) 
          : null,
      message: json[ApiKey.message] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.message: message,
      ApiKey.accessToken: accessToken,
      ApiKey.refreshToken: refreshToken,
      ApiKey.user: (user as UserModel).toJson(),
    };
  }
}
