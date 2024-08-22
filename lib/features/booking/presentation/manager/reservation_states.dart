import 'package:chalet_spot/core/error/failures.dart';

import '../../data/models/reservation_model.dart';

abstract class ReservationState {}

class ReservationInitial extends ReservationState {}

class ReservationLoading extends ReservationState {}

class ReservationSuccess extends ReservationState {
  List<ReservationModel> reservations;

  ReservationSuccess(this.reservations);
}

class ReservationError extends ReservationState {
  Failures failures;

  ReservationError(this.failures);
}

class ReservationUpdatedState extends ReservationState {}
