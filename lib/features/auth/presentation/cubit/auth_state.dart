import 'package:chefaa/core/shared%20classes/user_entity.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginSuccessState extends AuthState {
  final UserEntity user;

  LoginSuccessState({required this.user});
}

final class LoginIsLooadingState extends AuthState {}

final class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState({required this.message});
}

final class ForgetPasswordISLoadingState extends AuthState {}

final class ForgetPasswordSuccessState extends AuthState {
  final String message;

  ForgetPasswordSuccessState({required this.message});
}

final class ForgetPasswordErrorState extends AuthState {
  final String message;

  ForgetPasswordErrorState({required this.message});
}

final class ToggleTabState extends AuthState {
  final int index;
  ToggleTabState({required this.index});
}

final class ResetCodeISLoadingState extends AuthState {}

final class ResetCodeSuccessState extends AuthState {
  final String message;

  ResetCodeSuccessState({required this.message});
}

final class ResetCodeErrorState extends AuthState {
  final String message;

  ResetCodeErrorState({required this.message});
}


final class ResetPasswordISLoadingState extends AuthState {}

final class ResetPasswordSuccessState extends AuthState {
  final String message;

  ResetPasswordSuccessState({required this.message});
}

final class ResetPasswordErrorState extends AuthState {
  final String message;

  ResetPasswordErrorState({required this.message});
}