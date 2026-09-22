import 'dart:io';

import 'package:chefaa/core/services/storage_services.dart';
import 'package:chefaa/features/pharmacy/auth/domain/usecases/register_pharmacy_usecase.dart';
import 'package:chefaa/features/pharmacy/auth/presentation/cubit/pharmacy_auth_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyAuthCubit extends Cubit<PharmacyAuthState> {
  final RegisterPharmacyUsecase registerPharmacyUsecase;

  PharmacyAuthCubit({required this.registerPharmacyUsecase})
    : super(AuthPharmacyInitialState());

  final TextEditingController NameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController commNumber = TextEditingController();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  bool isTermsAccepted = false;
  void toggleTerms(bool? value) {
    isTermsAccepted = value ?? false;
    emit(AuthPharmacyInitialState());
  }

  String? selectedSpecialization;
  File? membershipFile;

  void setMembershipFile(File file) {
    membershipFile = file;
    emit(MembershipFileUpdatedState(membershipFile));
  }

  void removeMembershipFile() {
    membershipFile = null;
    emit(MembershipFileUpdatedState(null));
  }

  Future<void> registerPharmacy({required String role}) async {
    if (!isTermsAccepted) {
      emit(RegisterPharmacyErrorState('Please accept Terms & Conditions'));
      return;
    }
    if (!registerFormKey.currentState!.validate()) return;
    if (membershipFile == null) {
      emit(RegisterPharmacyErrorState("Please upload your membership card"));
      return;
    }

    if (registerFormKey.currentState!.validate()) {
      emit(RegisterPharmacyLoadingState());

      final name = NameController.text.trim();
      final generatedUsername =
          "${name.toLowerCase()}${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";

      final result = await registerPharmacyUsecase.call(
        name: name,
        userName: generatedUsername,
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: role,
        membershipFile: membershipFile!,
        commercialRegisterNumber: commNumber.text.trim(),
      );

      result.fold((error) => emit(RegisterPharmacyErrorState(error.message)), (
        authResult,
      ) async {
        await StorageServices.saveToken(authResult.accessToken);
        await StorageServices.saveRole(authResult.user?.role ?? role);
        if (authResult.user != null) {
          await StorageServices.saveUser(authResult.user!);
        }
        emit(RegisterPharmacySuccessState(authResult));
      });
    }
  }

  @override
  Future<void> close() {
    NameController.dispose();
    commNumber.dispose();

    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
