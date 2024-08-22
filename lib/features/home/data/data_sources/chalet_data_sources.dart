import 'package:chalet_spot/core/api/api_consumer.dart';
import 'package:chalet_spot/core/api/end_points.dart';
import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/features/home/data/models/chalet_model_response.dart';
import 'package:dartz/dartz.dart';

abstract class ChaletDataSources {
  Future<Either<Failures, ChaletModelResponse>> getChalets();

  Future<Either<Failures, String>> addToFav(String chaletId);
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
  Future<Either<Failures, String>> addToFav(String chaletId) async {
    try {
      var response = await api.post(EndPoints.addToFav, data: {
        "chaletId": chaletId,
      });
      return Right(response['msg']);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
