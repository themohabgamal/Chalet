import 'package:chalet_spot/core/error/failures.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileError extends EditProfileState {
  Failures failures;

  EditProfileError(this.failures);
}

class EditUpdatedState extends EditProfileState {}
