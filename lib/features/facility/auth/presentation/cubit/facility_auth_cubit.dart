import 'dart:io';
import 'package:chefaa/core/services/storage_services.dart';
import 'package:chefaa/features/facility/auth/domain/usecase/faciclity_usecase_register.dart';
import 'package:chefaa/features/facility/auth/presentation/cubit/facility_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacilityAuthCubit extends Cubit<FacilityAuthState> {
  final FaciclityUsecaseRegister useCase;

  FacilityAuthCubit({required this.useCase}) : super(AuthFacilityInitState());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController commNumber = TextEditingController();
  final TextEditingController directorName = TextEditingController();
  final TextEditingController directorId = TextEditingController();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  bool isTermsAccepted = false;
  void toggleTerms(bool? value) {
    isTermsAccepted = value ?? false;
    emit(AuthFacilityInitState());
  }

  String? selectedFacility;
  File? memberShip;

  void setMembershipFile(File file) {
    memberShip = file;
    emit(MembershipFileUpdatedState(memberShip));
  }

  void removeMembershipFile() {
    memberShip = null;
    emit(MembershipFileUpdatedState(null));
  }

  Future<void> registerfacility({required String role}) async {
    if (!isTermsAccepted) {
      emit(AuthFacilityErrorState('Please accept Terms & Conditions'));
      return;
    }
    if (!registerFormKey.currentState!.validate()) return;
    if (memberShip == null) {
      emit(AuthFacilityErrorState("Please upload your membership card"));
      return;
    }

    if (registerFormKey.currentState!.validate()) {
      emit(AuthFacilityLoadingState());

      final name = nameController.text.trim();
      final generatedUsername =
          "${name.toLowerCase()}${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";

      final result = await useCase.call(
        name: name,
        userName: generatedUsername,
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: role,
        commercialRegisterNumber: commNumber.text.trim(),
        medicalLicencePdf: memberShip!,
        facilityType: selectedFacility!,
        medicalDirectorName: directorName.text.trim(),
        directorProfessionalId: directorId.text.trim(),
      );

      result.fold((error) => emit(AuthFacilityErrorState(error.message)), (
        authResult,
      ) async {
        await StorageServices.saveToken(authResult.accessToken);
        await StorageServices.saveRole(authResult.user?.role ?? role);
        if (authResult.user != null) {
          await StorageServices.saveUser(authResult.user!);
        }
        emit(AuthFacilitySuccessState(authResult));
      });
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    directorId.dispose();
    directorName.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    commNumber.dispose();
    return super.close();
  }
}
