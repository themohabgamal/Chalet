import 'package:chalet_spot/core/api/api_consumer.dart';
import 'package:chalet_spot/core/api/end_points.dart';
import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/features/owner/home/data/models/chalet_model_response.dart';
import 'package:dartz/dartz.dart';

abstract class ChaletDataSources {
  Future<Either<Failures, ChaletModelResponse>> getChalets();

  Future<Either<Failures, String>> deleteChalets(String id);
}

class ChaletsRemoteDto extends ChaletDataSources {
  ApiConsumer api;

  ChaletsRemoteDto(this.api);

  @override
  Future<Either<Failures, ChaletModelResponse>> getChalets() async {
    try {
      var response = await api.get(
        EndPoints.chalet,
      );
      return Right(ChaletModelResponse.fromJson(response));
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteChalets(String id) async {
    try {
      var response = await api.delete(
        "${EndPoints.deleteChalet}/$id",
      );
      return Right(response['msg']);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
