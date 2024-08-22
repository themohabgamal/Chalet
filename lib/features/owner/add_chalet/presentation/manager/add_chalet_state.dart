import 'package:chalet_spot/core/error/failures.dart';

abstract class AddChaletState {}

class AddChaletInitial extends AddChaletState {}

class AddChaletLoading extends AddChaletState {}

class AddChaletSuccess extends AddChaletState {
  String msg;

  AddChaletSuccess(this.msg);
}

class AddChaletError extends AddChaletState {
  Failures failures;

  AddChaletError(this.failures);
}

class AddChaletUpdatedState extends AddChaletState {}
