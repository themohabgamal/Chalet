import 'package:chalet_spot/core/error/failures.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String name;
  final String token;
  final String role;

  AuthLoginSuccess(
      {required this.role, required this.name, required this.token});
}

class AuthLoginError extends AuthState {
  final Failures failures;

  AuthLoginError(this.failures);
}

class AuthRegisterLoading extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthRegisterError extends AuthState {
  final Failures failures;

  AuthRegisterError(this.failures);
}

class RegisterUpdatedState extends AuthState {}

class FirstTimeErrorState extends AuthState {
  String firebaseUid;

  FirstTimeErrorState(this.firebaseUid);
}
