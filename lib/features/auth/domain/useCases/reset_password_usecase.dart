import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/auth/domain/entities/reset_password_entity.dart';
import 'package:chefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUsecase {
  final AuthRepository authRepository;

  ResetPasswordUsecase({required this.authRepository});
  Future<Either<ErrorModel, ResetPasswordEntity>> call({
    required String identity,
    required String code,
    required String newPassword,
  }) async {
    return await authRepository.resetPass(
      identity: identity,
      code: code,
      newPassword: newPassword,
    );
  }
}
