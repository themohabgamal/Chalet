import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/features/booking/data/data_sources/reservation_dto.dart';
import 'package:chalet_spot/features/booking/data/models/reservation_model.dart';
import 'package:dartz/dartz.dart';
class ReservationRepo {
  ReservationDto reservationDto;

  ReservationRepo(this.reservationDto);

  Future<Either<Failures, List<ReservationModel>>> getReservations() =>
      reservationDto.getReservations();
}
