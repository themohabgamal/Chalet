import 'package:chalet_spot/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/add_chalet_dto.dart';
import '../models/add_chalet.dart';

class AddChaletRepo {
  AddChaletDto addChaletDto;

  AddChaletRepo(this.addChaletDto);

  Future<Either<Failures, String>> addChalet(AddChalet chalet) =>
      addChaletDto.addChalet(chalet);
}
