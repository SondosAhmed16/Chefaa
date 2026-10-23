import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/add_prescreption_model/add_prescreption_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/completed_appointment_model/completed_appointment_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/doctor_appointment_model/datum.dart';
import 'package:chefaa/features/doctor/appointment/data/model/edit_prescription_model/edit_prescription_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/paied_appointment_model/paied_appointment_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/previous_prescription_model/previous_prescription_model.dart';

sealed class DoctorAppoState {}

class DoctorAppoInitial extends DoctorAppoState {}

class DoctorAppoLoading extends DoctorAppoState {}

class DoctorAppoSuccess extends DoctorAppoState {
  final List<Datum> upcoming;
  final List<Datum> completed;

  final bool isUpcomingLoading;
  final bool isCompletedLoading;

  final int selectedIndex;

  DoctorAppoSuccess({
    required this.upcoming,
    required this.completed,
    this.selectedIndex = 0,
    this.isUpcomingLoading = false,
    this.isCompletedLoading = false,
  });

  List<Datum> get currentList => selectedIndex == 0 ? upcoming : completed;

  DoctorAppoSuccess copyWith({
    List<Datum>? upcoming,
    List<Datum>? completed,
    int? selectedIndex,
    bool? isUpcomingLoading,
    bool? isCompletedLoading,
  }) {
    return DoctorAppoSuccess(
      upcoming: upcoming ?? this.upcoming,
      completed: completed ?? this.completed,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isUpcomingLoading: isUpcomingLoading ?? this.isUpcomingLoading,
      isCompletedLoading: isCompletedLoading ?? this.isCompletedLoading,
    );
  }
}

class DoctorAppoError extends DoctorAppoState {
  final String error;

  DoctorAppoError({required this.error});
}

class AddPrescriptionLoading extends DoctorAppoState {}

class AddPrescriptionSuccess extends DoctorAppoState {
  final AddPrescreptionModel addPrescreptionModel;

  AddPrescriptionSuccess({required this.addPrescreptionModel});
}

class AddPrescriptionError extends DoctorAppoState {
  final ErrorModel error;

  AddPrescriptionError({required this.error});
}

class EditPrescriptionLoading extends DoctorAppoState {}
class EditPrescriptionSuccess extends DoctorAppoState {
  final EditPrescriptionModel editPrescriptionModel;
  EditPrescriptionSuccess({required this.editPrescriptionModel});
}
class EditPrescriptionError extends DoctorAppoState {
  final ErrorModel error;
  EditPrescriptionError({required this.error});
}

class CompleteAppoLoading extends DoctorAppoState {}

class CompleteAppoSuccess extends DoctorAppoSuccess {
  final CompletedAppointmentModel completedAppointmentModel;
  
  CompleteAppoSuccess({
    required this.completedAppointmentModel,
    required super.upcoming,
    required super.completed,
    super.selectedIndex,
    super.isUpcomingLoading,
    super.isCompletedLoading,
  });
}

class CompleteAppoError extends DoctorAppoState {
  final ErrorModel error;
  CompleteAppoError({required this.error});
}

class GetPreviousPrescriptionLoading extends DoctorAppoState {}

class GetPreviousPrescriptionSuccess extends DoctorAppoState {
  final PreviousPrescriptionModel previousPrescriptionModel;
  GetPreviousPrescriptionSuccess({required this.previousPrescriptionModel});
}

class GetPreviousPrescriptionError extends DoctorAppoState {
  final ErrorModel error;
  GetPreviousPrescriptionError({required this.error});
}

class MarkAppoPaiedLoading extends DoctorAppoState {}

class MarkAppoPaiedSuccess extends DoctorAppoState {
  final PaiedAppointmentModel paiedAppointmentModel;
  MarkAppoPaiedSuccess({required this.paiedAppointmentModel});
}

class MarkAppoPaiedError extends DoctorAppoState {
  final ErrorModel error;
  MarkAppoPaiedError({required this.error});
}