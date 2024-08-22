import 'package:chalet_spot/features/reserve/data/models/reserve_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/failures.dart';

abstract class ReserveDto {
  Future<Either<Failures, String>> addReserve(ReserveModel reserveModel);

  Future<Either<Failures, String>> addCode(String code);
}

class RemoteReserveDto extends ReserveDto {
  ApiConsumer api;

  RemoteReserveDto(this.api);

  @override
  Future<Either<Failures, String>> addReserve(ReserveModel reserveModel) async {
    try {
      var response = await api.post(EndPoints.reserveChalet, data: {
        "chaletId": reserveModel.chaletId,
        "stayType": reserveModel.stayType,
        "startDate": reserveModel.startDate,
        "endDate": reserveModel.endDate,
        "comment": reserveModel.comment,
        "code": reserveModel.code
      });
      return Right(response['msg']);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> addCode(String code) async {
    try {
      var response =
          await api.post(EndPoints.code, data: {"code": code});
      return Right(response['msg']);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
