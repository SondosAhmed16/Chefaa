import 'dart:io';
import 'package:chefaa/features/doctor/auth/data/data%20source/data_source_doctor_auth.dart';
import 'package:chefaa/features/pharmacy/auth/data/data%20source/data_source_pharmacy_auth.dart';
import 'package:chefaa/features/pharmacy/auth/domain/entities/register_pharmacy_response_entity.dart';
import 'package:chefaa/features/pharmacy/auth/domain/repository/register_pharmacy_reopsitory.dart';
import 'package:dartz/dartz.dart';
import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';

class RegisterPharmacyRepositoryImplement
    implements RegisterPharmacyReopsitory {
  final DataSourcePharmacyAuth dataSource;

  RegisterPharmacyRepositoryImplement({required this.dataSource});

  @override
  Future<Either<ErrorModel, RegisterPharmacyResponseEntity>> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required File membershipFile,
    required String commercialRegisterNumber,
  }) async {
    try {
      final response = await dataSource.register(
        name: name,
        userName: userName,
        phone: phone,
        email: email,
        password: password,
        role: role,
        membershipFile: membershipFile,
        commercialRegisterNumber: commercialRegisterNumber,
      );
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
