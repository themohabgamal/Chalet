import 'package:dartz/dartz.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/failures.dart';
import '../models/reservation_model.dart';

abstract class ReservationDto {
  Future<Either<Failures, List<ReservationModel>>> getReservations();
}

class RemoteReservationDto extends ReservationDto {
  ApiConsumer api;

  RemoteReservationDto(this.api);

  @override
  Future<Either<Failures, List<ReservationModel>>> getReservations() async {
    try {
      var response = await api.get(
        EndPoints.reservations,
      );
      print(response);
      List<ReservationModel> reservationModel =
          (response['reservations'] as List)
              .map((e) => ReservationModel.fromJson(e))
              .toList();
      return Right(reservationModel);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
