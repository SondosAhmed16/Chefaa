import 'package:chefaa/core/services/storage_services.dart';
import 'package:chefaa/features/patient/auth/domain/usecases/register_patient_usecase.dart';
import 'package:chefaa/features/patient/auth/presentation/cubit/patient_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientAuthCubit extends Cubit<PatientAuthState> {
  final RegisterPatientUsecase registerPatientUsecase;

  PatientAuthCubit({required this.registerPatientUsecase}) : super(AuthInitialState());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  bool isTermsAccepted = false;
  void toggleTerms(bool? value) {
    isTermsAccepted = value ?? false;
    emit(AuthInitialState());
  }

  Future<void> registerPatient({required String role}) async {
    if (!isTermsAccepted) {
      emit(RegisterErrorState('Please accept Terms & Conditions'));
      return;
    }

    if (registerFormKey.currentState!.validate()) {
      emit(RegisterLoadingState());

      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final fullName = "$firstName $lastName";
      final generatedUsername =
          "${firstName.toLowerCase()}${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";

      final result = await registerPatientUsecase.call(
        name: fullName,
        userName: generatedUsername,
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: role,
      );

      result.fold((error) => emit(RegisterErrorState(error.message)), (
        authResult,
      ) async {
        await StorageServices.saveToken(authResult.accessToken);
        await StorageServices.saveRole(authResult.user.role);
        await StorageServices.saveUser(authResult.user);
        emit(RegisterSuccessState(authResult));
      });
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
