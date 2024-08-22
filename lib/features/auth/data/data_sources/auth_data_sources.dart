import 'package:chalet_spot/core/api/api_consumer.dart';
import 'package:chalet_spot/features/auth/data/models/reg_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/error/failures.dart';
import '../models/login_response.dart';

abstract class AuthDataSources {
  Future<Either<Failures, RegResponseModel>> register(UserModel user);

  Future<Either<Failures, LoginResponse>> login(UserModel userData);

  Future<Either<Failures, LoginResponse>> loginWithGoogle(String idToken);
}

class AuthRemoteDto extends AuthDataSources {
  ApiConsumer api;

  AuthRemoteDto(this.api);

  @override
  Future<Either<Failures, RegResponseModel>> register(UserModel user) async {
    try {
      var response = await api.post(
        EndPoints.reg,
        data: {
          "name": user.name,
          "userName": user.userName,
          "password": user.password,
          "email": user.password,
          "phone": user.password,
          "city": user.city,
          "firebaseUid": user.firebaseUid
        },
      );
      return Right(RegResponseModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, LoginResponse>> login(UserModel userData) async {
    try {
      var response = await api.post(EndPoints.login, data: {
        "userName": userData.userName,
        "password": userData.password,
      });
      return Right(LoginResponse.fromJson(response));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, LoginResponse>> loginWithGoogle(
      String idToken) async {
    try {
      var response = await api.post(
        "/auth/firebase",
        data: {
          "idToken": idToken,
        },
      );
      return Right(LoginResponse.fromJson(response));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
