import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_cubit.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationSingleScreen extends StatelessWidget {
  final String reservationId;

  const ReservationSingleScreen({super.key, required this.reservationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OwnerCubit(DioConsumer(dio: Dio()))
        ..getReservationDetails(reservationId),
      child: BlocBuilder<OwnerCubit, OwnerState>(
        builder: (context, state) {
          if (state is OwnerLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ReservationSingleLoaded) {
            final reservation = state.reservation;
            return Scaffold(
              appBar: AppBar(
                title: const Text('تفاصيل الحجز'),
              ),
              body: Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اسم الحجز: ${reservation.user.name}', // Adjust based on your API response
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'اسم الشالية: ${reservation.chalet.name}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'تاريخ الحجز: ${reservation.reservationDate}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'تاريخ بدء الإقامة: ${reservation.startDate}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'تاريخ انتهاء الإقامة: ${reservation.endDate}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'نوع الإقامة: ${reservation.stayType}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'السعر الإجمالي: ${reservation.totalPrice}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'حالة الحجز: ${reservation.status}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
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
