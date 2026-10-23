import 'package:chefaa/features/doctor/home/data/model/clinic_model/break.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/clinic.dart';
import 'package:chefaa/features/doctor/home/domain/usecase/add_clinic_usecase.dart';
import 'package:chefaa/features/doctor/home/domain/usecase/delete_my_clinic.dart';
import 'package:chefaa/features/doctor/home/domain/usecase/get_clinics_usecase.dart';
import 'package:chefaa/features/doctor/home/domain/usecase/get_my_clinic_usecase.dart';
import 'package:chefaa/features/doctor/home/domain/usecase/update_clinic_usecase.dart';
import 'package:chefaa/features/doctor/home/presentation/cubit/doctor_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  final GetClinicsUsecase getClinicsUsecase;
  final GetMyClinicUsecase getMyClinicUsecase;
  final DeleteMyClinic deleteMyClinicUsecase;
  final UpdateClinicUsecase updateClinicUsecase;
  final AddClinicUsecase addClinicUsecase;

  DoctorHomeCubit({
    required this.getClinicsUsecase,
    required this.getMyClinicUsecase,
    required this.deleteMyClinicUsecase,
    required this.updateClinicUsecase,
    required this.addClinicUsecase,
  }) : super(DoctorHomeInitial());

  Future<void> getMyClinics({required String doctorId}) async {
    if (!isClosed) emit(DoctorClinicsLoading());

    final result = await getClinicsUsecase.call(doctorId: doctorId);
    result.fold(
      (error) => emit(DoctorClinicsError(error: error)),
      (clinics) => emit(DoctorClinicsSuccess(clinics: clinics.clinics)),
    );
  }

  Future<void> getMyClinic({required String clinicId}) async {
    if (!isClosed) emit(DoctorClinicLoading());

    final result = await getMyClinicUsecase.call(clinicId: clinicId);
    result.fold((error) => emit(DoctorClinicError(error: error)), (
      clinicModel,
    ) {
      currentClinic = clinicModel.clinic;
      emit(DoctorClinicSuccess(clinic: clinicModel.clinic));
    });
  }

  Future<void> deleteMyClinic({
    required String clinicId,
    required String doctorId,
  }) async {
    if (!isClosed) emit(DeleteClinicLoading());

    final result = await deleteMyClinicUsecase.call(clinicId: clinicId);
    result.fold((error) => emit(DeleteClinicError(error: error)), (message) {
      emit(DeleteClinicSuccess(message: message.message));
      getMyClinics(doctorId: doctorId);
    });
  }

  Future<void> updateClinic({
    required String clinicId,
    required String doctorId,
    Map<String, List<Break>>? dayBreaks,
  }) async {
    if (!isClosed) emit(UpdateClinicLoading());
    final result = await updateClinicUsecase.call(
      clinicID: clinicId,
      name: nameController.text.trim(),
      city: cityController.text.trim(),
      address: addressController.text.trim(),
      price: num.tryParse(priceController.text),
      operatingLicense: operatingLicenseController.text.trim(),
      location: _buildLocation(),
      schedule: _buildSchedule(dayBreaks: dayBreaks),
    );
    result.fold((error) => emit(UpdateClinicError(error: error)), (
      clinic,
    ) async {
      emit(UpdateClinicSuccess(clinic: clinic.clinic!));
      final clinicsResult = await getClinicsUsecase.call(doctorId: doctorId);
      clinicsResult.fold((_) => null, (clinics) {
        if (!isClosed) emit(DoctorClinicsSuccess(clinics: clinics.clinics));
      });
    });
  }

  Future<void> addClinic({required String doctorId}) async {
    if (!isClosed) emit(AddClinicLoading());

    final result = await addClinicUsecase.call(
      name: nameController.text.trim(),
      city: cityController.text.trim(),
      address: addressController.text.trim(),
      price: num.tryParse(priceController.text),
      operatingLicense: operatingLicenseController.text.trim(),
      location: _buildLocation(),
      schedule: _buildSchedule(),
    );

    result.fold((error) => emit(AddClinicError(error: error)), (
      clinicModel,
    ) async {
      currentClinic = clinicModel.clinic;
      emit(AddClinicSuccess());

      final clinicsResult = await getClinicsUsecase.call(doctorId: doctorId);
      clinicsResult.fold((_) => null, (clinics) {
        if (!isClosed) emit(DoctorClinicsSuccess(clinics: clinics.clinics));
      });
    });
  }

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final priceController = TextEditingController();
  final operatingLicenseController = TextEditingController();

  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final slotDurationController = TextEditingController();
  final dailyCapacityController = TextEditingController();
  final patientsPerSlotController = TextEditingController();

  String? doctorID;
  Clinic? currentClinic;

  String? activeDay;

  final Map<String, bool> selectedDays = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  final Map<String, TimeOfDay?> openTimes = {};
  final Map<String, TimeOfDay?> closeTimes = {};

  int _toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  Map<String, dynamic> _buildLocation() {
    return {
      "type": "Point",
      "coordinates": [
        double.tryParse(longitudeController.text) ?? 0.0,
        double.tryParse(latitudeController.text) ?? 0.0,
      ],
    };
  }

  List<Map<String, dynamic>> _buildDays({Map<String, List<Break>>? dayBreaks}) {
    return selectedDays.entries.where((e) => e.value).map((e) {
      final open = openTimes[e.key];
      final close = closeTimes[e.key];

      final breaks =
          dayBreaks?[e.key]
              ?.map((b) => {"start": b.start, "end": b.end, "label": b.label})
              .toList() ??
          [];

      return {
        "day": e.key,
        "isActive": true,
        "open": open != null ? _toMinutes(open) : 0,
        "close": close != null ? _toMinutes(close) : 0,
        "breaks": breaks,
      };
    }).toList();
  }

  Map<String, dynamic> _buildSchedule({Map<String, List<Break>>? dayBreaks}) {
    final activeDays = _buildDays(dayBreaks: dayBreaks);

    if (activeDays.isEmpty && currentClinic?.defaultSchedule != null) {
      return currentClinic!.defaultSchedule!.toMap();
    }

    return {
      "days": activeDays,
      "slotDuration":
          int.tryParse(slotDurationController.text) ??
          currentClinic?.defaultSchedule?.slotDuration ??
          30,
      "dailyCapacity":
          int.tryParse(dailyCapacityController.text) ??
          currentClinic?.defaultSchedule?.dailyCapacity ??
          20,
      "patientsPerSlot":
          int.tryParse(patientsPerSlotController.text) ??
          currentClinic?.defaultSchedule?.patientsPerSlot ??
          1,
    };
  }

  void onDayTap(String day) {
    selectedDays[day] = !(selectedDays[day] ?? false);
    activeDay = selectedDays[day] == true ? day : null;
    if (!isClosed) emit(DoctorHomeInitial());
  }

  Future<void> pickTime({
    required BuildContext context,
    required String day,
    required bool isOpen,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      if (isOpen) {
        openTimes[day] = picked;
      } else {
        closeTimes[day] = picked;
      }
      if (!isClosed) emit(DoctorHomeInitial());
    }
  }

  void resetDays() {
    for (final k in selectedDays.keys) {
      selectedDays[k] = false;
    }
    openTimes.clear();
    closeTimes.clear();
  }

  void resetForm() {
    nameController.clear();
    addressController.clear();
    cityController.clear();
    priceController.clear();
    operatingLicenseController.clear();
    latitudeController.clear();
    longitudeController.clear();
    slotDurationController.clear();
    dailyCapacityController.clear();
    patientsPerSlotController.clear();

    resetDays();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    priceController.dispose();
    operatingLicenseController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    return super.close();
  }
}
