import 'package:chefaa/features/patient/appointment/domain/use%20cases/get_patient_appo.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final GetPatientAppo usecase;

  AppointmentCubit({required this.usecase}) : super(AppointmentInitial());

  Future<void> fetchAppointments() async {
    emit(AppointmentLoading());

    final result = await usecase();

    result.fold(
      (error) {
        emit(AppointmentError(error.message));
      },
      (appointmentModel) {
        emit(AppointmentSuccess(appointmentModel.data ?? []));
      },
    );
  }
}
