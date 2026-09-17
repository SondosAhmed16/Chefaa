import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/core/shared%20classes/user_entity.dart';
import 'package:chefaa/features/patient/auth/domain/entities/register_patient_response_entity.dart';

class RegisterPatientModel extends RegisterPatientResponseEntity {
  RegisterPatientModel({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
    required super.message,
  });

  factory RegisterPatientModel.fromJson(Map<String, dynamic> json) {
    return RegisterPatientModel(
      accessToken: json[ApiKey.accessToken],
      refreshToken: json[ApiKey.refreshToken],
      user: UserModel.fromJson(json[ApiKey.user]),
      message: ApiKey.message,
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


