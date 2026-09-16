import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/auth/data/dataSource/data_source.dart';
import 'package:chefaa/features/auth/data/model/login_response_model.dart';
import 'package:chefaa/features/auth/data/model/reset_password_model.dart';

class DataSourceImplement implements DataSource {
  final ApiConsumer apiConsumer;

  DataSourceImplement({required this.apiConsumer});
  @override
  Future<LoginResponseModel> login({
    required String identity,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      ApiEndpoints.login,
      data: {"identity": identity, "password": password},
    );
    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<ResetPasswordModel> forgetPass({required String identity}) async {
    final response = await apiConsumer.post(
      ApiEndpoints.forgetPass,
      data: {"identity": identity},
    );

    return ResetPasswordModel.fromJson(response);
  }

  @override
  Future<ResetPasswordModel> verifyCode({
    required String identity,
    required String code,
  }) async {
    final response = await apiConsumer.post(
      ApiEndpoints.verifyCode,
      data: {"identity": identity, "code": code},
    );

    return ResetPasswordModel.fromJson(response);
  }

  @override
  Future<ResetPasswordModel> resetPass({
    required String identity,
    required String code,
    required String newPassword,
  }) async {
    final response = await apiConsumer.post(
      ApiEndpoints.resetPass,
      data: {"identity": identity, "code": code, "newPassword": newPassword},
    );

    return ResetPasswordModel.fromJson(response);
  }
}
