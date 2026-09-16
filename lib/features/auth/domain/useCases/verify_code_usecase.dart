import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/auth/domain/entities/reset_password_entity.dart';
import 'package:chefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyCodeUsecase {
  final AuthRepository authRepository;

  VerifyCodeUsecase({required this.authRepository});

  Future<Either<ErrorModel, ResetPasswordEntity>> call({
    required String identity,
    required String code,
  }) async {
    return await authRepository.verifyCode(identity: identity, code: code);
  }
}
