import 'package:chalet_spot/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:chalet_spot/features/auth/data/models/login_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/reg_response_model.dart';

class AuthRepo {
  AuthDataSources authDataSources;

  AuthRepo(this.authDataSources);

  Future<Either<Failures, RegResponseModel>> register(UserModel user) =>
      authDataSources.register(user);

  Future<Either<Failures, LoginResponse>> login(UserModel user) =>
      authDataSources.login(user);

  Future<Either<Failures, LoginResponse>> loginWithGoogle(String id) =>
      authDataSources.loginWithGoogle(id);
}
