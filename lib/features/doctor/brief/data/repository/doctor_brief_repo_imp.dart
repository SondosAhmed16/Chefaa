import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/doctor/brief/data/datasource/doctor_brief_datasource.dart';
import 'package:chefaa/features/doctor/brief/data/model/doctor_brief_model.dart';
import 'package:chefaa/features/doctor/brief/domain/repository/doctor_brief_repo.dart';
import 'package:dartz/dartz.dart';

class DoctorBriefRepoImp implements DoctorBriefRepo {
  final DoctorBriefDatasource datasource;

  DoctorBriefRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, DoctorBriefModel>> getDoctorBrief() async {
    try {
      final response = await datasource.getDoctorBrief();
      final model = DoctorBriefModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
