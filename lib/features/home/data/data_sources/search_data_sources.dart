import 'package:chalet_spot/core/api/api_consumer.dart';
import 'package:chalet_spot/core/api/end_points.dart';
import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/features/home/data/models/chalet_model_response.dart';
import 'package:dartz/dartz.dart';

abstract class SearchDto {
  Future<Either<Failures, ChaletModelResponse>> getChalets();
}

class SearchRemoteDto extends SearchDto {
  ApiConsumer api;

  SearchRemoteDto(this.api);

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
}
