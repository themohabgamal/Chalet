import 'package:chalet_spot/features/reserve/data/models/reserve_model.dart';
import 'package:chalet_spot/features/reserve/data/repositories/reserve_repo.dart';
import 'package:chalet_spot/features/reserve/presentation/manager/reserve_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/reserve_dto.dart';

class ReserveCubit extends Cubit<ReserveState> {
  ReserveDto reserveDto;

  ReserveCubit(this.reserveDto) : super(ReserveInitial());

  static ReserveCubit get(context) => BlocProvider.of(context);

  TextEditingController commentController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  void addReserve(ReserveModel reserveModel) async {
    emit(ReserveLoading());

    ReserveRepo reserveRepo = ReserveRepo(reserveDto);
    var result = await reserveRepo.addReserve(ReserveModel(
      stayType: reserveModel.stayType,
      startDate: reserveModel.startDate,
      endDate: reserveModel.endDate,
      comment: commentController.text,
      code: codeController.text,
      chaletId: reserveModel.chaletId,
    ));
    result.fold((l) {
      emit(ReserveError(l));
    }, (r) async {
      emit(ReserveSuccess(r));
    });
  }

  void addCode() async {
    if (codeController.text.isNotEmpty) {
      emit(ReserveCodeLoading());

      ReserveRepo reserveRepo = ReserveRepo(reserveDto);

      var result = await reserveRepo.addCode(codeController.text);
      result.fold((l) {
        emit(ReserveCodeError(l));
      }, (r) async {
        emit(ReserveCodeSuccess(r));
      });
    }
  }

}
