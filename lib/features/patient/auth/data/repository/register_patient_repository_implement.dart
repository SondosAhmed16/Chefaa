import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/auth/data/data%20source/data_source_patient_auth.dart';
import 'package:chefaa/features/patient/auth/domain/entities/register_patient_response_entity.dart';
import 'package:chefaa/features/patient/auth/domain/repository/register_patient_reopsitory.dart';
import 'package:dartz/dartz.dart';

class RegisterPatientRepositoryImplement implements RegisterPatientReopsitory {
  final DataSourcePatientAuth dataSource;

  RegisterPatientRepositoryImplement({required this.dataSource});

  @override
  Future<Either<ErrorModel, RegisterPatientResponseEntity>> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await dataSource.register(
        name: name,
        userName: userName,
        phone: phone,
        email: email,
        password: password,
        role: role,
      );
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
