import 'package:chalet_spot/features/booking/data/data_sources/reservation_dto.dart';
import 'package:chalet_spot/features/booking/data/models/reservation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/reservation_repo.dart';
import 'reservation_states.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationDto source;

  ReservationCubit(this.source) : super(ReservationInitial());

  static ReservationCubit get(context) => BlocProvider.of(context);

  List<ReservationModel> reservations = [];

  getReservations() async {
    emit(ReservationLoading());
    ReservationRepo reservationRepo = ReservationRepo(source);

    var response = await reservationRepo.getReservations();
    response.fold((l) {
      print(l.message);
      emit(ReservationError(l));
    }, (r) {
      reservations = r;
      emit(ReservationSuccess(r));
    });
  }
}
