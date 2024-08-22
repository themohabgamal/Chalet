import 'package:chalet_spot/features/home/data/data_sources/search_data_sources.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/chalet_model_response.dart';

class SearchRepo {
  SearchDto searchDto;

  SearchRepo(this.searchDto);

  Future<Either<Failures, ChaletModelResponse>> getChalets() =>
      searchDto.getChalets();
}
