import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/auth/data/dataSource/data_source.dart';
import 'package:chefaa/features/auth/domain/entities/login_response_entity.dart';
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
}
