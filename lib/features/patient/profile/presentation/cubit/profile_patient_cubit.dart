import 'package:chefaa/features/patient/profile/domain/entity/profile_patient_entity.dart';
import 'package:chefaa/features/patient/profile/domain/usecase/get_profile_usecase.dart';
import 'package:chefaa/features/patient/profile/domain/usecase/update_basic_info_usecase.dart';
import 'package:chefaa/features/patient/profile/domain/usecase/update_med_info_usecase.dart';
import 'package:chefaa/features/patient/profile/presentation/cubit/profile_patient_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientProfileCubit extends Cubit<ProfilePatientState> {
  final GetProfileUsecase getProfileUsecase;
  final UpdateBasicInfoUsecase updateBasicInfoUsecase;
  final UpdateMedInfoUsecase updateMedInfoUsecase;

  PatientProfileCubit({
    required this.getProfileUsecase,
    required this.updateBasicInfoUsecase,
    required this.updateMedInfoUsecase,
  }) : super(PatientProfileInitialState());

  static PatientProfileCubit get(BuildContext context) =>
      BlocProvider.of<PatientProfileCubit>(context);

  ProfilePatientEntity? currentProfile;

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final allergiesController = TextEditingController();
  final chronicConditionsController = TextEditingController();

  String? selectedGender;
  String? selectedBloodType;

  final List<String> genderList = ['male', 'female'];
  final List<String> bloodTypeList = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  void changeGender(String? newGender) {
    selectedGender = newGender;
    emit(GenderChangedState());
  }

  void changeBloodType(String? newBloodType) {
    selectedBloodType = newBloodType;
    emit(BloodTypeChangedState());
  }

  Future<void> getProfileData() async {
    emit(GetProfileLoadingState());
    final result = await getProfileUsecase();

    result.fold((error) => emit(GetProfileErrorState(error: error)), (profile) {
      currentProfile = profile;
      _populateFields(profile);
      emit(GetProfileSuccessState(profile: profile));
    });
  }

  Future<void> updateBasicInfo() async {
    emit(UpdateBasicInfoLoadingState());

    final result = await updateBasicInfoUsecase(
      name: nameController.text.isNotEmpty ? nameController.text : null,
      age: num.tryParse(ageController.text),
      gender: selectedGender,
      height: num.tryParse(heightController.text),
      weight: num.tryParse(weightController.text),
    );

    result.fold((error) => emit(UpdateBasicInfoErrorState(error: error)), (
      updatedProfile,
    ) {
      currentProfile = ProfilePatientEntity(
        userName: updatedProfile.userName ?? currentProfile?.userName,
        age: updatedProfile.age ?? currentProfile?.age,
        gender: updatedProfile.gender ?? currentProfile?.gender,
        height: updatedProfile.height ?? currentProfile?.height,
        weight: updatedProfile.weight ?? currentProfile?.weight,
        bloodType: currentProfile?.bloodType,
        allergiesList: currentProfile?.allergiesList,
        chronicConditionsList: currentProfile?.chronicConditionsList,
      );

      _populateFields(currentProfile!);
      emit(UpdateBasicInfoSuccessState(profile: currentProfile!));
    });
  }

  Future<void> updateMedInfo() async {
    emit(UpdateMedInfoLoadingState());

    final allergiesList = allergiesController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final chronicList = chronicConditionsController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final result = await updateMedInfoUsecase(
      bloodType: selectedBloodType,
      allergiesList: allergiesList.isNotEmpty ? allergiesList : null,
      chronicConditionsList: chronicList.isNotEmpty ? chronicList : null,
    );

    result.fold((error) => emit(UpdateMedInfoErrorState(error: error)), (
      updatedProfile,
    ) {
      final finalAllergies =
          (updatedProfile.allergiesList != null &&
              updatedProfile.allergiesList!.isNotEmpty)
          ? updatedProfile.allergiesList
          : (allergiesList.isNotEmpty
                ? allergiesList
                : currentProfile?.allergiesList);

      final finalChronic =
          (updatedProfile.chronicConditionsList != null &&
              updatedProfile.chronicConditionsList!.isNotEmpty)
          ? updatedProfile.chronicConditionsList
          : (chronicList.isNotEmpty
                ? chronicList
                : currentProfile?.chronicConditionsList);

      currentProfile = ProfilePatientEntity(
        userName: currentProfile?.userName,
        age: currentProfile?.age,
        gender: currentProfile?.gender,
        height: currentProfile?.height,
        weight: currentProfile?.weight,

        bloodType:
            updatedProfile.bloodType ??
            selectedBloodType ??
            currentProfile?.bloodType,
        allergiesList: finalAllergies,
        chronicConditionsList: finalChronic,
      );

      _populateFields(currentProfile!);
      emit(UpdateMedInfoSuccessState(profile: currentProfile!));
    });
  }

  void _populateFields(ProfilePatientEntity profile) {
    nameController.text = profile.userName ?? '';
    ageController.text = profile.age?.toString() ?? '';
    heightController.text = profile.height?.toString() ?? '';
    weightController.text = profile.weight?.toString() ?? '';

    selectedGender = profile.gender;
    selectedBloodType = profile.bloodType;

    allergiesController.text = profile.allergiesList?.join(', ') ?? '';
    chronicConditionsController.text =
        profile.chronicConditionsList?.join(', ') ?? '';
  }

  @override
  Future<void> close() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    allergiesController.dispose();
    chronicConditionsController.dispose();
    return super.close();
  }
}
