import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/brief/data/model/doctor_brief_model.dart';

sealed class DoctorBriefState {}

class DoctorBriefInitial extends DoctorBriefState {}

class GetDoctorBriefLoading extends DoctorBriefState {}

class GetDoctorBriefSuccess extends DoctorBriefState {
  final DoctorBriefModel doctorBrief;
  GetDoctorBriefSuccess({required this.doctorBrief});
}

class GetDoctorBriefFailure extends DoctorBriefState {
  final ErrorModel errorModel;
  GetDoctorBriefFailure({required this.errorModel});
}


