import 'package:chefaa/features/auth/data/model/login_response_model.dart';
import 'package:chefaa/features/auth/data/model/reset_password_model.dart';

abstract class DataSource {
  Future<LoginResponseModel> login({
    required String identity,
    required String password,
  });

  Future<ResetPasswordModel> forgetPass({required String identity});

  Future<ResetPasswordModel> verifyCode({
    required String identity,
    required String code,
  });

  Future<ResetPasswordModel> resetPass({
    required String identity,
    required String code,
    required String newPassword,
  });
}
