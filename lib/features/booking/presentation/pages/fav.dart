import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/booking/data/data_sources/reservation_dto.dart';
import 'package:chalet_spot/features/booking/presentation/manager/reservation_cubit.dart';
import 'package:chalet_spot/features/booking/presentation/manager/reservation_states.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/text_styles.dart';
import '../widgets/fav_cart.dart';

class BookingTab extends StatelessWidget {
  const BookingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ReservationCubit(RemoteReservationDto(DioConsumer(dio: Dio())))
            ..getReservations(),
      child: BlocConsumer<ReservationCubit, ReservationState>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: MyAppBar(
              title: Text(
                "Booking".tr(),
                style: TextStyles.appBarTitle(),
              ),
              centerTitle: true,
            ),
            body: state is ReservationSuccess
                ? ReservationCubit.get(context).reservations.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(
                          child: Text(
                            "لم تحجز بعد",
                            style: TextStyles.poppins16w500(),
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => FavCard(
                          bookingId: ReservationCubit.get(context)
                              .reservations[index]
                              .id,
                          bookingDate: ReservationCubit.get(context)
                              .reservations[index]
                              .startDate,
                          location: ReservationCubit.get(context)
                                  .reservations[index]
                                  .chalet
                                  ?.address ??
                              "",
                          image: ReservationCubit.get(context)
                                  .reservations[index]
                                  .chalet
                                  ?.imgs[0]
                                  .img ??
                              "",
                          title: ReservationCubit.get(context)
                                  .reservations[index]
                                  .chalet
                                  ?.name ??
                              "",
                          totalReviews: 120,
                          rate: 3,
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 2.h,
                        ),
                        itemCount:
                            ReservationCubit.get(context).reservations.length,
                      )
                : state is ReservationError
                    ? Center(
                        child: Text(state.failures.message),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => const ShimmerFavCard(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 2.h,
                        ),
                        itemCount: 4,
                      ),
          ),
        ),
      ),
    );
  }
}
