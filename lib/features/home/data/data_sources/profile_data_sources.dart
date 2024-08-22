import 'package:chalet_spot/core/api/api_consumer.dart';
import 'package:chalet_spot/core/api/end_points.dart';
import 'package:chalet_spot/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../models/profile_respons_model.dart';

abstract class ProfileDataSources {
  Future<Either<Failures, ProfileResponseModel>> getProfile();
  Future<Either<Failures, ProfileResponseModel>> editProfile();
}

class ProfileRemoteDto extends ProfileDataSources {
  ApiConsumer api;

  ProfileRemoteDto(this.api);

  @override
  Future<Either<Failures, ProfileResponseModel>> getProfile() async {
    try {
      var response = await api.get(
        EndPoints.profile,
      );
      return Right(ProfileResponseModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ProfileResponseModel>> editProfile() {
    // TODO: implement editProfile
    throw UnimplementedError();
  }
}
