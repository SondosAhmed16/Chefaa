import 'package:chefaa/features/patient/appointment/domain/use%20cases/cancel_appointment_usecase.dart';
import 'package:chefaa/features/patient/appointment/domain/use%20cases/get_patient_appo.dart';
import 'package:chefaa/features/patient/appointment/domain/use%20cases/reschedual_appo_usecase.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final GetPatientAppo usecase;
  final ReschedualAppoUsecase reschedualAppoUsecase;
  final CancelAppointmentUsecase cancelAppointmentUsecase;

  AppointmentCubit({
    required this.usecase,
    required this.reschedualAppoUsecase,
    required this.cancelAppointmentUsecase,
  }) : super(AppointmentInitial());

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

  Future<void> cancelAppo({required String appointmentId}) async {
    emit(CancelLoadingState());
    final result = await cancelAppointmentUsecase(appointmentId: appointmentId);
    result.fold(
      (error) {
        emit(CancelErrorState(error: error.message));
      },
      (response) async {
        if (response.data != null) {
          emit(CancelSuccessState(appointment: response.data!));
          await fetchAppointments();
        } else {
          emit(CancelErrorState(error: response.message.toString()));
        }
      },
    );
  }

  Future<void> reschedualAppointment({
    required String appointmentId,
    required String date,
    required String slotStart,
    required String slotEnd,
    required String timeChosed,
  }) async {
    emit(RescheduleLoadingState());

    final result = await reschedualAppoUsecase(
      appointmentId: appointmentId,
      date: date,
      slotStart: slotStart,
      slotEnd: slotEnd,
      timeChosed: timeChosed,
    );

    result.fold(
      (error) {
        emit(RescheduleErrorState(error: error.message));
      },
      (response) async {
        if (response.data != null) {
          emit(RescheduleSuccessState(appointment: response.data!));
          await fetchAppointments();
        } else {
          emit(RescheduleErrorState(error: response.message.toString()));
        }
      },
    );
  }
}
