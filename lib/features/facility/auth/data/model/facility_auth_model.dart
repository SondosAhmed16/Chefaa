import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/core/shared%20classes/user_entity.dart';
import 'package:chefaa/features/facility/auth/domain/entity/facility_register_entity.dart';

class FacilityAuthModel extends FacilityRegisterEntity {
  FacilityAuthModel({
    required super.message,
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });

  factory FacilityAuthModel.fromJson(Map<String, dynamic> json) {
    return FacilityAuthModel(
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
