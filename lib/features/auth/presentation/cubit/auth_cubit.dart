import 'package:chefaa/core/services/storage_services.dart';
import 'package:chefaa/features/auth/domain/useCases/forget_password_usecase.dart';
import 'package:chefaa/features/auth/domain/useCases/login_usecase.dart';
import 'package:chefaa/features/auth/domain/useCases/reset_password_usecase.dart';
import 'package:chefaa/features/auth/domain/useCases/verify_code_usecase.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  final VerifyCodeUsecase verifyCodeUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;

  final TextEditingController identityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> forgetPasswordformKey = GlobalKey<FormState>();

  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> verifyCodeFormKey = GlobalKey<FormState>();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  AuthCubit({
    required this.loginUsecase,
    required this.forgetPasswordUsecase,
    required this.verifyCodeUsecase,
    required this.resetPasswordUsecase,
  }) : super(AuthInitial());

  int selectedTabIndex = 0;

  void selectTab(int index) {
    selectedTabIndex = index;
    emit(ToggleTabState(index: selectedTabIndex));
  }

  String get currentIdentity => selectedTabIndex == 0
      ? emailController.text.trim()
      : phoneController.text.trim();

  Future<void> login() async {
    emit(LoginIsLooadingState());

    final result = await loginUsecase.call(
      identity: identityController.text,
      password: passwordController.text,
    );

    result.fold(
      (error) {
        emit(LoginErrorState(message: error.message));
      },
      (loginResponse) async {
        await StorageServices.saveToken(loginResponse.accessToken);
        await StorageServices.saveRole(loginResponse.user.role);
        await StorageServices.saveUser(loginResponse.user);

        emit(LoginSuccessState(user: loginResponse.user));
      },
    );
  }

  Future<void> forgetPass() async {
    if (!forgetPasswordformKey.currentState!.validate()) return;

    emit(ForgetPasswordISLoadingState());
    final result = await forgetPasswordUsecase.call(identity: currentIdentity);

    result.fold(
      (error) {
        emit(ForgetPasswordErrorState(message: error.message));
      },
      (resetResponse) async {
        emit(ForgetPasswordSuccessState(message: resetResponse.message));
      },
    );
  }

  Future<void> verifyCode() async {
    if (verifyCodeFormKey.currentState != null &&
        !verifyCodeFormKey.currentState!.validate())
      return;

    emit(ResetCodeISLoadingState());
    final result = await verifyCodeUsecase.call(
      identity: currentIdentity,
      code: codeController.text,
    );

    result.fold(
      (error) => emit(ResetCodeErrorState(message: error.message)),
      (response) => emit(ResetCodeSuccessState(message: response.message)),
    );
  }

  Future<void> resetPassword() async {
    if (!resetPasswordFormKey.currentState!.validate()) return;

    emit(ResetPasswordISLoadingState());
    final result = await resetPasswordUsecase.call(
      identity: currentIdentity,
      code: codeController.text,
      newPassword: newPasswordController.text,
    );

    result.fold(
      (error) => emit(ResetPasswordErrorState(message: error.message)),
      (response) => emit(ResetPasswordSuccessState(message: response.message)),
    );
  }

  String get formattedIdentity {
    final identity = currentIdentity;
    final isEmail = selectedTabIndex == 0;

    if (isEmail) {
      return identity;
    } else {
      final visiblePart = identity.substring(0, identity.length - 3);
      return '$visiblePart***';
    }
  }

  @override
  Future<void> close() {
    identityController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
