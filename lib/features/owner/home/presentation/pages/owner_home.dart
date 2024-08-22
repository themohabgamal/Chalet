import 'dart:developer';

import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/error/failures.dart';
import 'package:chalet_spot/core/utils/app_icons.dart';
import 'package:chalet_spot/core/utils/cache_helper.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/core/utils/text_styles.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_cubit.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_state.dart';
import 'package:chalet_spot/features/owner/home/presentation/pages/reservations_screen.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../config/routes/routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../widgets/admin_chalet_card.dart';

class OwnerHome extends StatelessWidget {
  const OwnerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OwnerCubit(DioConsumer(dio: Dio()))..getChalets(),
      child: DefaultTabController(
        length: 2,
        child: BlocBuilder<OwnerCubit, OwnerState>(
          builder: (context, state) {
            if (state is OwnerLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is OwnerLoaded) {
              final chalets = state.chalets;

              return Scaffold(
                appBar: AppBar(
                  title: Text("أهلا بك ${CacheHelper.getData('name')}"),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.start, (route) => false);
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
                  ],
                  bottom: TabBar(
                    tabs: [
                      Tab(
                          child: Text("قائمة الشاليهات",
                              style: TextStyles.poppins18w500())),
                      Tab(
                          child: Text('الحجوزات',
                              style: TextStyles.poppins18w500())),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    // First Tab - List of Chalets
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    width: 270.w,
                                    child: Text(
                                      "هذه هي لوحة التحكم الخاصة بشاليهاتك",
                                      style: TextStyles.poppins16w500(
                                          color: AppColors.darkGreyM),
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(bottom: 10),
                              itemBuilder: (context, index) {
                                return AdminChaletCard(
                                  onEditTap: () {
                                    final chaletId = chalets[index].id;
                                    Navigator.pushNamed(
                                      context,
                                      Routes.ownerSingleChalet,
                                      arguments: chaletId,
                                    );
                                  },
                                  onTrashTap: () {},
                                  chaletId: chalets[index].id,
                                  chaletName: chalets[index].name,
                                  chaletCity: chalets[index].city,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 12.h),
                              itemCount: chalets.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Second Tab - Reservations
                    const ReservationsScreen(),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.sp),
                  ),
                  backgroundColor: AppColors.onboardDarkBlue,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.addChalet);
                  },
                  child: Icon(
                    Icons.add,
                    size: 45.sp,
                    color: AppColors.lightGreen,
                  ),
                ),
              );
            } else if (state is OwnerError) {
              log("ssssssss ${state.error.message}");
              if (state.error.message == 'Dio Error') {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Icon(
                        Icons.error_outline,
                        color: AppColors.lightGreen,
                        size: 100.sp,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "session_expired"
                                .tr(), // Translation for "Session Expired"
                            style: TextStyles.poppins20(color: Colors.black),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "please_login_and_try_again"
                                .tr(), // Translation for "Please login and try again"
                            style: TextStyles.poppins18w500(),
                          ),
                          SizedBox(height: 20.h),
                          MyButton(
                            text:
                                'login_now'.tr(), // Translation for "Login Now"
                            onPressed: () {
                              // Clear token and other session data
                              CacheHelper.removeData('token');
                              CacheHelper.removeData('name');
                              CacheHelper.removeData('role');

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.login,
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
              } else {
                return Center(child: Text(state.error.message));
              }
            } else {
              return const SizedBox.shrink();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
