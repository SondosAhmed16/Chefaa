import 'package:chefaa/features/doctor/brief/presentation/cubit/doctor_brief_state.dart';
import 'package:chefaa/features/doctor/brief/domain/repository/doctor_brief_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorBriefCubit extends Cubit<DoctorBriefState> {
  final DoctorBriefRepo doctorBriefRepo;

  DoctorBriefCubit({required this.doctorBriefRepo})
    : super(DoctorBriefInitial());

  Future<void> getDoctorBrief() async {
    emit(GetDoctorBriefLoading());

    final result = await doctorBriefRepo.getDoctorBrief();

    result.fold(
      (errorModel) => emit(GetDoctorBriefFailure(errorModel: errorModel)),
      (doctorBrief) => emit(GetDoctorBriefSuccess(doctorBrief: doctorBrief)),
    );
  }
}
