import 'package:chefaa/core/services/storage_services.dart';
import 'package:chefaa/features/auth/domain/useCases/login_usecase.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;

  AuthCubit({required this.loginUsecase}) : super(AuthInitial());
  final TextEditingController identityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  @override
  Future<void> close() {
    identityController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
