import 'dart:io';
import 'package:chefaa/features/doctor/auth/data/data%20source/data_source_doctor_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/doctor/auth/domain/entities/register_doctor_response_entity.dart';
import 'package:chefaa/features/doctor/auth/domain/repository/register_doctor_reopsitory.dart';

class RegisterDoctorRepositoryImplement implements RegisterDoctorReopsitory {
  final DataSourceDoctorAuth dataSource;

  RegisterDoctorRepositoryImplement({required this.dataSource});

  @override
  Future<Either<ErrorModel, RegisterDoctorResponseEntity>> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required String specialization,
    required File membershipFile,
  }) async {
    try {
      final response = await dataSource.register(
        name: name,
        userName: userName,
        phone: phone,
        email: email,
        password: password,
        role: role,
        specialization: specialization,
        membershipFile: membershipFile,
      );
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}