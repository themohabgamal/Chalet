import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/data/models/reg_response_model.dart';
import '../data_sources/edit_profile_data_sources.dart';
import '../model/edit_profile_respons_model.dart';

class EditProfileRepo {
  EditProfileDto editProfileDto;

  EditProfileRepo(this.editProfileDto);

  Future<Either<Failures, EditProfileResponseModel>> editProfile(UserModel user) =>
      editProfileDto.editProfile(user);
}
