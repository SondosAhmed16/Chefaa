import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/features/patient/onboarding/domain/usecase/patient_all_info_usacse.dart';
import 'all_info_state.dart';

class AllInfoCubit extends Cubit<AllInfoState> {
  final PatientAllInfoUsacse updateAllInfoUseCase;

  AllInfoCubit({required this.updateAllInfoUseCase})
    : super(AllInfoInitialState());

  static AllInfoCubit get(context) => BlocProvider.of(context);

  final PageController pageController = PageController();
  int currentPageIndex = 0;

  String? selectedGender;
  final TextEditingController dobController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String? selectedBloodType;

  List<String> selectedChronicConditions = [];
  final TextEditingController otherChronicController = TextEditingController();

  List<String> selectedAllergies = [];
  final TextEditingController otherAllergyController = TextEditingController();

  double? lat;
  double? lng;
  String? addressText;

  void onPageChanged(int index) {
    currentPageIndex = index;
    emit(AllInfoPageChangedState(index));
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void toggleChronicCondition(String condition) {
    if (selectedChronicConditions.contains(condition)) {
      selectedChronicConditions.remove(condition);
    } else {
      selectedChronicConditions.add(condition);
    }
    emit(AllInfoFormUpdatedState());
  }

  void toggleAllergy(String allergy) {
    if (selectedAllergies.contains(allergy)) {
      selectedAllergies.remove(allergy);
    } else {
      selectedAllergies.add(allergy);
    }
    emit(AllInfoFormUpdatedState());
  }

  int? _calculateAgeFromDOB(String dobText) {
    try {
      final parts = dobText.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        final birthDate = DateTime(year, month, day);
        final today = DateTime.now();
        int age = today.year - birthDate.year;
        if (today.month < birthDate.month ||
            (today.month == birthDate.month && today.day < birthDate.day)) {
          age--;
        }
        return age;
      }
    } catch (_) {}
    return null;
  }

  Future<void> submitAllInfo() async {
    emit(AllInfoLoadingState());

    final age = _calculateAgeFromDOB(dobController.text);
    final weight = double.tryParse(weightController.text);
    final height = double.tryParse(heightController.text);

    List<String> finalChronic = List.from(selectedChronicConditions);
    if (otherChronicController.text.isNotEmpty) {
      finalChronic.add(otherChronicController.text.trim());
    }

    List<String> finalAllergies = List.from(selectedAllergies);
    if (otherAllergyController.text.isNotEmpty) {
      finalAllergies.add(otherAllergyController.text.trim());
    }

    final result = await updateAllInfoUseCase(
      gender: selectedGender,
      age: age,
      weight: weight,
      height: height,
      bloodType: selectedBloodType,
      chronicConditions: finalChronic,
      allergies: finalAllergies,
      addressText: addressText,
      lat: lat,
      lng: lng,
    );

    result.fold(
      (error) => emit(AllInfoErrorState(error)),
      (response) => emit(AllInfoSuccessState(response)),
    );
  }
}
