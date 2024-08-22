import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_cubit.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OwnerCubit(DioConsumer(dio: Dio()))..getReservations(),
      child: BlocBuilder<OwnerCubit, OwnerState>(
        builder: (context, state) {
          if (state is OwnerLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ReservationLoaded) {
            final reservations = state.reservations;

            return Scaffold(
              body: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  return ListTile(
                    tileColor: AppColors.lightGreen,
                    title: Text(reservation.user.name),
                    subtitle: Text(
                        'من: ${reservation.startDate}\nالي: ${reservation.endDate}'),
                    trailing: Text(reservation.status),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'reservationSingleScreen',
                        arguments: reservation.id,
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemCount: reservations.length,
              ),
            );
          } else if (state is OwnerError) {
            return Center(child: Text(state.error.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
