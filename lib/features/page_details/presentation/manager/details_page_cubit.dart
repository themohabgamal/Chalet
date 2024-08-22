import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/data_sources/single_chalet_dto.dart';
import '../../data/models/single_chalet_response_model.dart';
import '../../data/repositories/chalet_repo.dart';
import 'details_page_state.dart';

class DetailsPageCubit extends Cubit<DetailsPageState> {
  SingleChaletDto dto;

  DetailsPageCubit(this.dto) : super(DetailsPageInitial());

  static DetailsPageCubit get(context) => BlocProvider.of(context);

  Chalet chalet = Chalet();

  // Define the date format
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  List<DateTime> disabledDates = [];

  void launchWhatsApp({required String phone, required String message}) async {
    final url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  getChalet(String chaletId) async {
    emit(GetChaletLoading());
    ChaletRepo profileRepo = ChaletRepo(dto);

    var result = await profileRepo.getChalet(chaletId);

    result.fold((l) {
      emit(GetChaletError(l));
    }, (r) async {
      chalet = r.chalet!;
      emit(
        GetChaletSuccess(r.chalet!),
      );
    });
  }

  getReservedDates(String chaletId) async {
    emit(GetReservationDatesLoading());
    ChaletRepo profileRepo = ChaletRepo(dto);

    var result = await profileRepo.getReservedDates(chaletId);

    result.fold((l) {
      emit(GetReservationDatesError(l));
    }, (r) async {
      disabledDates =
          r.map((dateString) => dateFormat.parse(dateString)).toList();
      emit(
        GetReservationDatesSuccess(disabledDates),
      );
    });
  }
}
