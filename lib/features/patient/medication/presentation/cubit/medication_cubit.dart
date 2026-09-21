import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/medication/domain/repository/medication_repo.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicationCubit extends Cubit<MedicationState> {
  final MedicationRepo repo;

  MedicationCubit({required this.repo}) : super(MedicationInitialState());

  static MedicationCubit get(BuildContext context) =>
      BlocProvider.of<MedicationCubit>(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController formController = TextEditingController();
  TextEditingController timesPerDayController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  bool isActive = false;
  bool _isMedicationListLoading = false;
  bool _hasLoadedMedicationList = false;

  int timesPerDay = 1;

  void setTimesPerDay(String value) {
    timesPerDayController.text = value;

    switch (value) {
      case "Once a day (1)":
        timesPerDay = 1;
        break;

      case "Every 12 hours":
        timesPerDay = 2;
        break;

      case "Every 8 hours":
        timesPerDay = 3;
        break;

      case "As needed":
        timesPerDay = 0;
        break;

      default:
        timesPerDay = 1;
    }
  }

  Future<void> addMedication() async {
    if (!isClosed) emit(MedicationAdditionLoadingState());
    try {
      final medicationResponse = await repo.addMedication(
        name: nameController.text,
        dosage: "${dosageController.text} mg",
        form: formController.text,
        timesPerDay: timesPerDay,
        schedule: scheduleController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        startDate: startDateController.text,
        endDate: endDateController.text,
        isActive: isActive,
      );
      if (!isClosed) {
        emit(
          MedicationAdditionSuccessState(
            medicationResponse: medicationResponse,
          ),
        );
      }
    } catch (e) {
      if (!isClosed)
        emit(MedicationAdditionErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getMedicationList({bool forceRefresh = false}) async {
  if (_isMedicationListLoading) return;
  if (_hasLoadedMedicationList && !forceRefresh) return;

  _isMedicationListLoading = true;
  if (!isClosed) emit(MedicationListLoadingState());

  try {
    final medicationList = await repo.getMedicationList();
    _hasLoadedMedicationList = true;
    if (!isClosed) {
      emit(MedicationListSuccessState(medications: medicationList));
    }
  } catch (e) {
    if (!isClosed) {
      String errorMsg = e is ErrorModel ? (e.message ?? 'Unknown Error') : e.toString();
      emit(MedicationListErrorState(errorMessage: errorMsg));
    }
  } finally {
    _isMedicationListLoading = false;
  }
}

Future<void> ConfirmMedication({required String medicationId}) async {
  if (!isClosed) emit(MedicationConfirmLoadingState());

  try {
    final confirmRes = await repo.confirmMedication(medicationId);

    final currentState = state;
    if (currentState is MedicationListSuccessState) {
      final updateMedication = currentState.medications.medications?.map((e) {
        if (e.id == medicationId) {
          num? parsedAdherence = confirmRes.adherenceRate is num
              ? confirmRes.adherenceRate as num
              : num.tryParse(confirmRes.adherenceRate?.toString() ?? '');

          return e.copyWith(adherencePercentage: parsedAdherence);
        }
        return e;
      }).toList();

      if (!isClosed) {
        emit(
          MedicationListSuccessState(
            medications: currentState.medications.copyWith(
              medications: updateMedication,
            ),
          ),
        );
      }
    }
    if (!isClosed) {
      emit(MedicationConfirmSuccessState(confirmMedication: confirmRes));
    }
  } catch (e) {
    if (!isClosed) {
      String errorMsg = e is ErrorModel ? (e.message ?? 'Unknown Error') : e.toString();
      emit(MedicationConfirmErrorState(errorMessage: errorMsg));
    }
  }
}
  Future<void> updateMedication({required String medicationId}) async {
    if (!isClosed) emit(MedicationUpdateLoadingState());

    try {
      final medicationResponse = await repo.updateMedication(
        medicationId: medicationId,
        name: nameController.text,
        dosage: "${dosageController.text} mg",
        form: formController.text,
        timesPerDay: timesPerDay,
        schedule: scheduleController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        startDate: startDateController.text,
        endDate: endDateController.text,
        isActive: isActive,
      );
      if (!isClosed) {
        emit(
          MedicationUpdateSuccessState(medicationResponse: medicationResponse),
        );
      }
    } catch (e) {
      if (!isClosed)
        emit(MedicationUpdateErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> deleteMedication(String medicationId) async {
    if (!isClosed) emit(MedicationDeleteLoadingState());

    try {
      final medicationResponse = await repo.deleteMedication(medicationId);
      if (!isClosed) {
        emit(
          MedicationDeleteSuccessState(medicationResponse: medicationResponse),
        );
      }
    } catch (e) {
      if (!isClosed)
        emit(MedicationDeleteErrorState(errorMessage: e.toString()));
    }
  }

}