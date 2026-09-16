import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/auth/domain/entities/reset_password_entity.dart';
import 'package:chefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUsecase {
  final AuthRepository authRepository;

  ForgetPasswordUsecase({required this.authRepository});

  Future<Either<ErrorModel, ResetPasswordEntity>> call({
    required String identity,
  }) async {
    return await authRepository.forgetPass(identity: identity);
  }
}
