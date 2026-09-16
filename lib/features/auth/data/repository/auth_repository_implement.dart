import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/auth/data/dataSource/data_source.dart';
import 'package:chefaa/features/auth/domain/entities/login_response_entity.dart';
import 'package:chefaa/features/auth/domain/entities/reset_password_entity.dart';
import 'package:chefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImplement implements AuthRepository {
  final DataSource dataSource;

  AuthRepositoryImplement({required this.dataSource});
  @override
  Future<Either<ErrorModel, LoginResponseEntity>> login({
    required String identity,
    required String password,
  }) async {
    try {
      final response = await dataSource.login(
        identity: identity,
        password: password,
      );
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ResetPasswordEntity>> forgetPass({
    required String identity,
  }) async {
    try {
      final response = await dataSource.forgetPass(identity: identity);
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ResetPasswordEntity>> verifyCode({
    required String identity,
    required String code,
  }) async {
    try {
      final response = await dataSource.verifyCode(
        identity: identity,
        code: code,
      );
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ResetPasswordEntity>> resetPass({
    required String identity,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await dataSource.resetPass(
        identity: identity,
        code: code,
        newPassword: newPassword,
      );
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
