import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/brief/data/model/doctor_brief_model.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorBriefRepo {
  Future<Either<ErrorModel,DoctorBriefModel>> getDoctorBrief();
 

}