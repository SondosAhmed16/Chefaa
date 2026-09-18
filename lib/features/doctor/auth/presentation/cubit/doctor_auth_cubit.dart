import 'dart:io';

import 'package:chefaa/core/services/storage_services.dart';
import 'package:chefaa/features/doctor/auth/domain/usecases/register_doctor_usecase.dart';
import 'package:chefaa/features/doctor/auth/presentation/cubit/doctor_auth_state.dart';
import 'package:chefaa/features/patient/auth/presentation/cubit/patient_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAuthCubit extends Cubit<DoctorAuthState> {
  final RegisterDoctorUsecase registerDoctorUsecase;

  DoctorAuthCubit({required this.registerDoctorUsecase})
    : super(AuthDoctorInitialState());

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
    emit(AuthDoctorInitialState());
  }

  String? selectedSpecialization;
  File? membershipFile;

  void setMembershipFile(File file) {
    membershipFile = file;
    emit(AuthDoctorInitialState());
  }

  void removeMembershipFile() {
    membershipFile = null;
    emit(AuthDoctorInitialState());
  }

  Future<void> registerDoctor({required String role}) async {
    if (!isTermsAccepted) {
      emit(RegisterDoctorErrorState('Please accept Terms & Conditions'));
      return;
    }
    if (!registerFormKey.currentState!.validate()) return;
    if (membershipFile == null) {
      emit(RegisterDoctorErrorState("Please upload your membership card"));
      return;
    }

    if (registerFormKey.currentState!.validate()) {
      emit(RegisterDoctorLoadingState());

      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final fullName = "$firstName $lastName";
      final generatedUsername =
          "${firstName.toLowerCase()}${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";

      final result = await registerDoctorUsecase.call(
        name: fullName,
        userName: generatedUsername,
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: role,
        specialization: selectedSpecialization!,
        membershipFile: membershipFile!,
      );

      result.fold((error) => emit(RegisterDoctorErrorState(error.message)), (
        authResult,
      ) async {
        await StorageServices.saveToken(authResult.accessToken);
        await StorageServices.saveRole(authResult.user?.role ?? role);
        if (authResult.user != null) {
          await StorageServices.saveUser(authResult.user!);
        }
        emit(RegisterOctorSuccessState(authResult));
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
