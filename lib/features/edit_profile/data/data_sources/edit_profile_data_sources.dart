import 'package:chalet_spot/core/api/api_consumer.dart';
import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/features/auth/data/models/reg_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/end_points.dart';
import '../model/edit_profile_respons_model.dart';

abstract class EditProfileDto {
  Future<Either<Failures, EditProfileResponseModel>> editProfile(UserModel user);
}

class EditProfileRemoteDto extends EditProfileDto {
  ApiConsumer api;

  EditProfileRemoteDto(this.api);

  @override
  Future<Either<Failures, EditProfileResponseModel>> editProfile(
      UserModel user) async {
    try {
      var response = await api.post(EndPoints.changeInfo, data: {
        "name": user.name,
        "email": user.email,
      });
      return Right(EditProfileResponseModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
