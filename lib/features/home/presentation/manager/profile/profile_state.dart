import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/features/auth/data/models/reg_response_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  UserModel user;

  ProfileSuccess(this.user);
}

class ProfileError extends ProfileState {
  Failures failures;

  ProfileError(this.failures);
}

class EditProfileInitial extends ProfileState {}

class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {}

class EditProfileError extends ProfileState {
  Failures failures;

  EditProfileError(this.failures);
}

class EditUpdatedState extends ProfileState {}
