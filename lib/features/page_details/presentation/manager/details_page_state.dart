import 'package:chalet_spot/core/error/failures.dart';

import '../../data/models/single_chalet_response_model.dart';

abstract class DetailsPageState {}

class DetailsPageInitial extends DetailsPageState {}

class GetChaletLoading extends DetailsPageState {}

class GetChaletSuccess extends DetailsPageState {
  Chalet chalet;

  GetChaletSuccess(this.chalet);
}

class GetChaletError extends DetailsPageState {
  Failures failures;

  GetChaletError(this.failures);
}

class GetReservationDatesLoading extends DetailsPageState {}

class GetReservationDatesSuccess extends DetailsPageState {
  List<DateTime> disabledDates;

  GetReservationDatesSuccess(this.disabledDates);
}

class GetReservationDatesError extends DetailsPageState {
  Failures failures;

  GetReservationDatesError(this.failures);
}
