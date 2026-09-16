import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/auth/domain/entities/reset_password_entity.dart';

class ResetPasswordModel extends ResetPasswordEntity {
  ResetPasswordModel({required super.message});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(message: json[ApiKey.message]);
  }

  Map<String, dynamic> toJson() {
    return {ApiKey.message: message};
  }
}
