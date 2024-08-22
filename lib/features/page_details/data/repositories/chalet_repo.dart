import 'package:chalet_spot/features/page_details/data/data_sources/single_chalet_dto.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/single_chalet_response_model.dart';

class ChaletRepo {
  SingleChaletDto singleChaletDto;

  ChaletRepo(this.singleChaletDto);

  Future<Either<Failures, SingleChaletResponseModel>> getChalet(
          String chaletId) =>
      singleChaletDto.getChalet(chaletId);

  Future<Either<Failures, List<dynamic>>> getReservedDates(String chaletId) =>
      singleChaletDto.getReservedDates(chaletId);
}
