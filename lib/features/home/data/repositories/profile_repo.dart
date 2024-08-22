import 'package:chalet_spot/features/home/data/data_sources/profile_data_sources.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/profile_respons_model.dart';

class ProfileRepo {
  ProfileDataSources profileDataSources;

  ProfileRepo(this.profileDataSources);

  Future<Either<Failures, ProfileResponseModel>> getProfile() =>
      profileDataSources.getProfile();
}
