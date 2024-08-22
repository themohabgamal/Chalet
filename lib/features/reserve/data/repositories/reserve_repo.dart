import 'package:chalet_spot/features/reserve/data/models/reserve_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../data_sources/reserve_dto.dart';

class ReserveRepo {
  ReserveDto reserveDto;

  ReserveRepo(this.reserveDto);

  Future<Either<Failures, String>> addReserve(ReserveModel reserveModel) =>
      reserveDto.addReserve(reserveModel);
  Future<Either<Failures, String>> addCode(String code) =>
      reserveDto.addCode(code);
}
