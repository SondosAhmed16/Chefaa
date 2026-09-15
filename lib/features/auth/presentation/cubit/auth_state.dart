import 'package:chefaa/features/auth/domain/entities/login_response_entity.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState{}

final class LoginSuccessState extends AuthState{
  final UserEntity user;

  LoginSuccessState({required this.user});
}

final class LoginIsLooadingState extends AuthState{}

final class LoginErrorState extends AuthState{
  final String message;

  LoginErrorState({required this.message});

}