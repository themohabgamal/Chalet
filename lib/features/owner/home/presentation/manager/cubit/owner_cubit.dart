import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/features/owner/home/data/models/owner_chalet.dart';
import 'package:chalet_spot/features/owner/home/data/models/owner_single_chalet_model.dart';
import 'package:chalet_spot/features/owner/home/data/models/reservation.dart';
import 'package:chalet_spot/features/owner/home/data/models/reservation_details.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_state.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/cache_helper.dart';

class OwnerCubit extends Cubit<OwnerState> {
  final DioConsumer dioConsumer;

  OwnerCubit(this.dioConsumer) : super(OwnerInitial());

  Future<void> getChalets() async {
    emit(OwnerLoading());
    try {
      final String? token = CacheHelper.getData(
          'token'); // Assuming 'token' is stored in shared preferences
      log(token.toString());

      if (token != null) {
        final response = await Dio().get(
          'https://chaletspot.vercel.app/owner/chalets?limit=50',
          options: Options(headers: {'token': token}),
        );

        if (response.statusCode == 403) {
          // Token expired or forbidden access
          CacheHelper.removeData(
              'token'); // Clear the token from shared preferences
          emit(OwnerError(
              CachedFailures("Session expired. Please log in again.")));
          return;
        }

        // Assuming the response structure is something like:
        // { "chalets": [ { ... }, { ... } ] }
        final List<dynamic> chaletsJson = response.data['chalets'];
        final chalets =
            chaletsJson.map((json) => OwnerChalet.fromJson(json)).toList();

        emit(OwnerLoaded(chalets));
      } else {
        emit(OwnerError(CachedFailures("No token found")));
      }
    } catch (e) {
      emit(OwnerError(ServerFailures("Dio Error")));
    }
  }

  Future<void> getChaletDetails(String chaletId) async {
    emit(OwnerLoading());
    try {
      // Replace ':id' with the actual chaletId in the URL
      final url = 'https://chaletspot.vercel.app/owner/chalets/$chaletId';

      // Retrieve the token from shared preferences (assuming you have a method to do this)
      final token = await CacheHelper.getData('token');
      log('user token $token');
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );

      // Parse the response to the OwnerSingleChaletModel
      final chalet = OwnerSingleChaletModel.fromJson(response.data['chalet']);

      // Emit the loaded state with the chalet details
      emit(OwnerSingleChaletLoaded(chalet: chalet));
    } catch (e) {
      // Emit the error state if something goes wrong
      emit(OwnerError(ServerFailures(e.toString())));
    }
  }

  Future<void> getReservations() async {
    emit(OwnerLoading());
    final token = await CacheHelper.getData('token');

    try {
      final response = await dioConsumer.dio.get(
        'https://chaletspot.vercel.app/owner/reservations',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      final reservations = (response.data['reservations'] as List)
          .map((data) => Reservation.fromJson(data))
          .toList();
      emit(ReservationLoaded(reservations));
    } catch (e) {
      emit(OwnerError(ServerFailures(e.toString())));
    }
  }

  Future<void> getReservationDetails(String reservationId) async {
    emit(OwnerLoading());
    final token = await CacheHelper.getData('token');

    try {
      final response = await dioConsumer.dio.get(
        'https://chaletspot.vercel.app/owner/reservations/$reservationId',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );

      // Print the raw response data
      print(response.data);

      // Check if the response contains the 'reservation' key
      final reservationData = response.data['reservation'];

      if (reservationData != null) {
        // Parse the reservation data
        final reservation = ReservationDetails.fromJson(reservationData);
        print(reservation.chalet.name);
        emit(ReservationSingleLoaded(reservation));
      } else {
        emit(OwnerError(CachedFailures("No reservation found")));
      }
    } catch (e) {
      emit(OwnerError(ServerFailures(e.toString())));
    }
  }
}
