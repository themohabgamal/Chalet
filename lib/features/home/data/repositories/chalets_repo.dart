import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../data_sources/chalet_data_sources.dart';
import '../models/chalet_model_response.dart';

class ChaletsRepo {
  ChaletDataSources chaletDataSources;

  ChaletsRepo(this.chaletDataSources);

  Future<Either<Failures, ChaletModelResponse>> getChalets() =>
      chaletDataSources.getChalets();

  Future<Either<Failures, String>> addToFav(String chaletId) =>
      chaletDataSources.addToFav(chaletId);
}
