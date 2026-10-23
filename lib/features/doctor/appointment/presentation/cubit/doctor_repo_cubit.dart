import 'package:chefaa/features/doctor/appointment/domain/repository/doctor_appointment_repo.dart';
import 'package:chefaa/features/doctor/appointment/domain/usecase/get_mu_appo_repo.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_appo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/doctor_appointment_model/datum.dart';

enum PaymentOption { prePay, atClinic }

class DoctorRepoCubit extends Cubit<DoctorAppoState> {
  final GetMuAppoRepo getMuAppoRepo;
  final DoctorAppointmentRepo doctorAppointmentRepo;

  DoctorRepoCubit({
    required this.getMuAppoRepo,
    required this.doctorAppointmentRepo,
  }) : super(DoctorAppoInitial());

  void changeTab(int index) {
    if (state is DoctorAppoSuccess) {
      final currentState = state as DoctorAppoSuccess;
      emit(currentState.copyWith(selectedIndex: index));
    }
  }

  Future<void> getAppo() async {
    if (!isClosed) {
      emit(
        DoctorAppoSuccess(
          upcoming: [],
          completed: [],
          selectedIndex: 0,
          isUpcomingLoading: true,
          isCompletedLoading: false,
        ),
      );
    }

    try {
      final eitherResult = await getMuAppoRepo.call();

      eitherResult.fold(
        (errorModel) {
          if (!isClosed) {
            emit(DoctorAppoError(error: errorModel.message));
          }
        },
        (patients) {
          final upcoming = patients
              .where(
                (e) =>
                    (e.status?.toLowerCase() == "upcoming") &&
                    (e.paymentStatus != null &&
                        e.paymentStatus?.toLowerCase() != "cancelled"),
              )
              .toList();

          final completed = patients
              .where(
                (e) =>
                    (e.status?.toLowerCase() == "completed") &&
                    (e.paymentStatus != null &&
                        e.paymentStatus?.toLowerCase() != "cancelled"),
              )
              .toList();

          if (!isClosed) {
            emit(
              DoctorAppoSuccess(
                upcoming: upcoming,
                completed: completed,
                selectedIndex: 0,
                isUpcomingLoading: false,
                isCompletedLoading: false,
              ),
            );
          }
        },
      );
    } catch (e) {
      if (!isClosed) emit(DoctorAppoError(error: e.toString()));
    }
  }

  Future<void> addPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  }) async {
    if (isClosed) return;

    emit(AddPrescriptionLoading());

    final result = await doctorAppointmentRepo.addPrescription(
      appointment: appointment,
      diagnosis: diagnosis,
      medicines: medicines,
      labTests: labTests,
      imaging: imaging,
      nextVisit: nextVisit,
      notes: notes,
    );

    result.fold(
      (errorModel) {
        if (!isClosed) {
          emit(AddPrescriptionError(error: errorModel));
        }
      },
      (responseModel) {
        if (!isClosed) {
          emit(AddPrescriptionSuccess(addPrescreptionModel: responseModel));
        }
      },
    );
  }

  Future<void> editPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  }) async {
    if (isClosed) return;

    emit(EditPrescriptionLoading());

    final result = await doctorAppointmentRepo.editPrescription(
      appointment: appointment,
      diagnosis: diagnosis,
      medicines: medicines,
      labTests: labTests,
      imaging: imaging,
      nextVisit: nextVisit,
      notes: notes,
    );

    result.fold(
      (errorModel) {
        if (!isClosed) {
          emit(EditPrescriptionError(error: errorModel));
        }
      },
      (responseModel) {
        if (!isClosed) {
          emit(EditPrescriptionSuccess(editPrescriptionModel: responseModel));
        }
      },
    );
  }

  Future<void> completeAppo({required String appoId}) async {
    if (isClosed) return;

    final currentState = state;

    emit(CompleteAppoLoading());

    final result = await doctorAppointmentRepo.completeAppo(appoId: appoId);

    result.fold(
      (errorModel) {
        if (!isClosed) {
          emit(CompleteAppoError(error: errorModel));
        }
      },
      (responseModel) async {
        if (!isClosed) {
          if (currentState is DoctorAppoSuccess) {
            final updatedUpcoming = List<Datum>.from(currentState.upcoming);
            final updatedCompleted = List<Datum>.from(currentState.completed);

            final index = updatedUpcoming.indexWhere((e) => e.id == appoId);
            if (index != -1) {
              final completedAppointment = updatedUpcoming.removeAt(index);
              completedAppointment.status = "completed";
              updatedCompleted.add(completedAppointment);
            }

            emit(
              DoctorAppoSuccess(
                upcoming: updatedUpcoming,
                completed: updatedCompleted,
                selectedIndex: currentState.selectedIndex,
              ),
            );
          }

          await Future.delayed(const Duration(milliseconds: 300));
          await getAppo();
        }
      },
    );
  }

  Future<void> getPreviousPrescription({required String appoId}) async {
    if (isClosed) return;

    emit(GetPreviousPrescriptionLoading());

    final result = await doctorAppointmentRepo.getPreviousPrescription(
      appoId: appoId,
    );

    result.fold(
      (errorModel) {
        if (!isClosed) {
          emit(GetPreviousPrescriptionError(error: errorModel));
        }
      },
      (responseModel) {
        if (!isClosed) {
          emit(
            GetPreviousPrescriptionSuccess(
              previousPrescriptionModel: responseModel,
            ),
          );
        }
      },
    );
  }

  Future<void> markAppoPaied({required String appoId}) async {
    if (isClosed) return;

    emit(MarkAppoPaiedLoading());

    final result = await doctorAppointmentRepo.markAppoPaied(appoId: appoId);

    result.fold(
      (errorModel) {
        if (!isClosed) {
          emit(MarkAppoPaiedError(error: errorModel));
        }
      },
      (responseModel) async {
        if (!isClosed) {
          emit(MarkAppoPaiedSuccess(paiedAppointmentModel: responseModel));

          await Future.delayed(const Duration(milliseconds: 300));
          await getAppo();
        }
      },
    );
  }
}
