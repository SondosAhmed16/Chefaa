import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/auth/domain/entities/login_response_entity.dart';
import 'package:chefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<Either<ErrorModel,LoginResponseEntity>> call({
    required String identity,
    required String password

  })async{
    return await authRepository.login(identity: identity, password: password);
  }
}