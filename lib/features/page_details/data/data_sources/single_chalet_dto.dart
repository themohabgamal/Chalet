import 'package:dartz/dartz.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/failures.dart';
import '../models/single_chalet_response_model.dart';

abstract class SingleChaletDto {
  Future<Either<Failures, SingleChaletResponseModel>> getChalet(
      String chaletId);

  Future<Either<Failures, List<dynamic>>> getReservedDates(String chaletId);
}

class SingleChaletRemoteDto extends SingleChaletDto {
  ApiConsumer api;

  SingleChaletRemoteDto(this.api);

  @override
  Future<Either<Failures, SingleChaletResponseModel>> getChalet(
      String chaletId) async {
    try {
      var response = await api.get(
        "${EndPoints.singleChalet}/$chaletId",
      );
      return Right(SingleChaletResponseModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<dynamic>>> getReservedDates(
      String chaletId) async {
    try {
      var response = await api.get(
        "${EndPoints.reservedDates}/$chaletId",
      );
      print("hiii${response['reservedDates']}");
      return Right(response['reservedDates']);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
