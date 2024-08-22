import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/features/owner/home/data/models/owner_chalet.dart';
import 'package:chalet_spot/features/owner/home/data/models/owner_single_chalet_model.dart';
import 'package:chalet_spot/features/owner/home/data/models/reservation.dart';
import 'package:chalet_spot/features/owner/home/data/models/reservation_details.dart';
import 'package:chalet_spot/features/page_details/data/models/single_chalet_response_model.dart';

sealed class OwnerState {}

final class OwnerInitial extends OwnerState {}

final class OwnerLoading extends OwnerState {}

final class OwnerLoaded extends OwnerState {
  final List<OwnerChalet> chalets;

  OwnerLoaded(this.chalets);
}

final class OwnerError extends OwnerState {
  final Failures error;

  OwnerError(this.error);
}

class OwnerSingleChaletLoaded extends OwnerState {
  final OwnerSingleChaletModel chalet;

  OwnerSingleChaletLoaded({required this.chalet});

  @override
  List<Object> get props => [chalet];
}

// States for fetching the list of reservations
class ReservationLoaded extends OwnerState {
  final List<Reservation> reservations; // Adjust type based on API response

  ReservationLoaded(this.reservations);

  @override
  List<Object?> get props => [reservations];
}

// States for fetching a single reservation
class ReservationSingleLoaded extends OwnerState {
  final ReservationDetails reservation; // Adjust type based on API response

  ReservationSingleLoaded(this.reservation);

  @override
  List<Object?> get props => [reservation];
}
