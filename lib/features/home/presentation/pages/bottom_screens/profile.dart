import 'package:chalet_spot/config/routes/routes.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/app_icons.dart';
import 'package:chalet_spot/core/utils/cache_helper.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/home/data/data_sources/profile_data_sources.dart';
import 'package:chalet_spot/features/home/presentation/manager/profile/profile_cubit.dart';
import 'package:chalet_spot/features/home/presentation/manager/profile/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../booking/data/data_sources/reservation_dto.dart';
import '../../../../booking/presentation/manager/reservation_cubit.dart';
import '../../../../booking/presentation/manager/reservation_states.dart';
import '../../../../booking/presentation/widgets/fav_cart.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(ProfileRemoteDto(DioConsumer(dio: Dio())))..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: MyAppBar(
              leading: EasyLocalization.of(context)!.locale ==
                      const Locale('ar')
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Routes.start);
                        CacheHelper.removeData('name');
                        CacheHelper.removeData('role');
                        CacheHelper.removeData('token');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 7.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              12.sp,
                            ),
                          ),
                          border: Border.all(
                            color: AppColors.lightGrey,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        child: const Icon(Icons.logout),
                      ),
                    )
                  : const SizedBox(),
              actions: [
                EasyLocalization.of(context)!.locale == const Locale('ar')
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Routes.start);
                          CacheHelper.removeData('name');
                          CacheHelper.removeData('role');
                          CacheHelper.removeData('token');
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                12.sp,
                              ),
                            ),
                            border: Border.all(
                              color: AppColors.lightGrey,
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          child: const Icon(Icons.logout),
                        ),
                      ),
              ],
              title: Text(
                "Profile".tr(),
                style: TextStyles.appBarTitle(),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SizedBox(
                        height: 220,
                        child: Column(
                          children: [
                            SizedBox(
                                height: 150.h,
                                width: double.infinity,
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    'https://i.pinimg.com/564x/f4/20/9d/f4209d9648766c06a998b9ca6d53c300.jpg')),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 24.w,
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 65.sp,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: const NetworkImage(
                              'https://i.pinimg.com/564x/5e/c5/07/5ec507d7c25f6ddb1f82e6976696807b.jpg',
                            ),
                            radius: 60.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                ProfileCubit.get(context).user.name ?? "..",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyles.poppins24(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (ProfileCubit.get(context).user.name !=
                                    null) {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.editProfile,
                                    arguments: ProfileCubit.get(context).user,
                                  );
                                }
                              },
                              child: SvgPicture.asset(
                                AppIcons.edit,
                              ),
                            ),
                          ],
                        ),
                        Text(
                            "@${ProfileCubit.get(context).user.userName ?? ""}")
                      ],
                    ),
                  ),
                  BlocProvider(
                    create: (BuildContext context) => ReservationCubit(
                        RemoteReservationDto(DioConsumer(dio: Dio())))
                      ..getReservations(),
                    child: BlocConsumer<ReservationCubit, ReservationState>(
                      listener: (context, state) {},
                      builder: (context, state) => state is ReservationSuccess
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
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
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 2.h,
                                  ),
                                  itemCount: ReservationCubit.get(context)
                                      .reservations
                                      .length,
                                )
                          : state is ReservationError
                              ? Center(
                                  child: Text(state.failures.message),
                                )
                              : ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      const ShimmerFavCard(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 2.h,
                                  ),
                                  itemCount: 4,
                                ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
