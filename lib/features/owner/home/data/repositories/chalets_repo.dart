import 'package:chalet_spot/features/owner/home/data/data_sources/chalet_data_sources.dart';
import 'package:chalet_spot/features/owner/home/data/models/chalet_model_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

class ChaletsRepo {
  ChaletDataSources chaletDataSources;

  ChaletsRepo(this.chaletDataSources);

  Future<Either<Failures, ChaletModelResponse>> getChalets() =>
      chaletDataSources.getChalets();

  Future<Either<Failures, String>> deleteChalets(String id) =>
      chaletDataSources.deleteChalets(id);
}
