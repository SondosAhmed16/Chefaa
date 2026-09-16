import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/auth/domain/entities/login_response_entity.dart';
import 'package:chefaa/features/auth/domain/entities/reset_password_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<ErrorModel, LoginResponseEntity>> login({
    required String identity,
    required String password,
  });


  Future<Either<ErrorModel, ResetPasswordEntity>> forgetPass({
    required String identity,
  });


  Future<Either<ErrorModel, ResetPasswordEntity>> verifyCode({
    required String identity,
    required String code,
  });

  
  Future<Either<ErrorModel, ResetPasswordEntity>> resetPass({
    required String identity,
    required String code,
    required String newPassword,
  });
}
