import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chalet_spot/config/routes/routes.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/home/data/data_sources/chalet_data_sources.dart';
import 'package:chalet_spot/features/home/presentation/manager/home_tab/home_tab_cubit.dart';
import 'package:chalet_spot/features/home/presentation/manager/home_tab/home_tab_state.dart';
import 'package:chalet_spot/features/home/presentation/widgets/chalets_card.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/app_icons.dart';
import 'package:chalet_spot/core/utils/app_images.dart';
import 'package:chalet_spot/core/utils/text_styles.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../widgets/chalets_spot_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeTabCubit(ChaletsRemoteDto(DioConsumer(dio: Dio())))
            ..getLocation()
            ..getChalets(),
      child: BlocConsumer<HomeTabCubit, HomeTabState>(
        listener: (context, state) {
          if (state is HomeTabGetChaletsError) {
            if (state.failures.message == "Invalid Token") {
              showDialog(
                  barrierDismissible: false,
                  context: (context),
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
                              "session_expired".tr(),
                              style: TextStyles.poppins20(color: Colors.black),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "please_login_and_try_again".tr(),
                              style: TextStyles.poppins18w500(),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            MyButton(
                              text: 'login_now'.tr(),
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.login,
                                  (route) => false,
                                );
                              },
                            )
                          ],
                        ),
                      ));
            }
          }
        },
        builder: (context, state) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  surfaceTintColor: AppColors.lightGreyS,
                  foregroundColor: AppColors.lightGreyS,
                  backgroundColor: Colors.white,
                  toolbarHeight: 150.h,
                  elevation: 10,
                  shadowColor: Colors.black,
                  snap: true,
                  floating: true,
                  expandedHeight: 120.h,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding:
                        EdgeInsets.zero, // Ensures no padding around the title
                    centerTitle:
                        false, // Aligns the title to the start (left or right based on text direction)
                    title: Container(
                      width: double
                          .infinity, // Makes sure the container takes full width
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Aligns children to the start
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              AppImages.logo,
                              width: 80.w,
                              height: 60.h,
                            ),
                          ),
                          SizedBox(height: 10.h), // Add spacing if necessary
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Hey".tr(),
                                    style: TextStyles.poppins18w500(
                                        color: AppColors.black),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    ", ${CacheHelper.getData('name') ?? ""}",
                                    style: TextStyles.poppins16w500(
                                        color: AppColors.black),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.sp)),
                                  border:
                                      Border.all(color: AppColors.lightGrey),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  top: 2.h,
                                  right: 5.w,
                                  bottom: 10.h,
                                ),
                                child: badges.Badge(
                                  position: badges.BadgePosition.custom(
                                    top: -10.h,
                                    start: 8.w,
                                  ),
                                  onTap: () {},
                                  badgeContent: Text(
                                    "0",
                                    style: TextStyles.poppins12w500(
                                        color: Colors.white),
                                  ),
                                  badgeAnimation:
                                      const badges.BadgeAnimation.rotation(
                                    animationDuration: Duration(seconds: 1),
                                    loopAnimation: false,
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                  badgeStyle: badges.BadgeStyle(
                                    shape: badges.BadgeShape.circle,
                                    badgeColor: AppColors.red,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.w, vertical: 6.h),
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  child:
                                      SvgPicture.asset(AppIcons.notification),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                            ),
                            child: BlocBuilder<HomeTabCubit, HomeTabState>(
                                builder:
                                    (BuildContext context, HomeTabState state) {
                              if (state is HomeTabGetBannersLoading) {
                                return const ShimmerWidget(
                                  height: 200,
                                );
                              } else if (state is HomeTabGetBannersSuccess) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      enableInfiniteScroll: true,
                                      height:
                                          200.h, // Adjust the height as needed
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(
                                          seconds: 4), // Slower scroll interval
                                      autoPlayAnimationDuration: const Duration(
                                          milliseconds:
                                              1000), // Slow down the animation duration
                                      enlargeCenterPage: false,
                                      aspectRatio: 16 / 9,
                                      viewportFraction:
                                          1.5, // Adjust viewportFraction to make images larger
                                      scrollPhysics:
                                          const BouncingScrollPhysics(), // Optional: adds a bounce effect
                                    ),
                                    items: state.banners.map((banner) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5
                                                    .w), // Adjust horizontal padding
                                            child: CachedNetworkImage(
                                              imageUrl: banner.img,
                                              fit: BoxFit
                                                  .cover, // Adjust this if needed, e.g., BoxFit.fill or BoxFit.contain
                                              placeholder: (context, url) =>
                                                  ShimmerWidget(height: 200.h),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else if (state is HomeTabGetBannersError) {
                                return const Center();
                              } else {
                                return const ShimmerWidget(
                                  height: 200,
                                );
                              }
                            })),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  "ChaletSpot Picks".tr(),
                                  style: TextStyles.poppins16w500(
                                    weight: FontWeight.w700,
                                    color: AppColors.onboardDarkBlue,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Text(
                                  "View more".tr(),
                                  style: TextStyles.poppins14w500(
                                      color: AppColors.darkGreen),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 325.h,
                          child: BlocBuilder<HomeTabCubit, HomeTabState>(
                            builder:
                                (BuildContext context, HomeTabState state) {
                              if (state is HomeTabGetChaletsLoading) {
                                return ListView.separated(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      const ShimmerChaletsCard(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 10.w),
                                  itemCount: 4,
                                );
                              } else if (state is HomeTabGetChaletsSuccess ||
                                  HomeTabCubit.get(context)
                                      .chalets
                                      .isNotEmpty) {
                                return ListView.separated(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      BlocBuilder<HomeTabCubit, HomeTabState>(
                                    builder: (context, state) => ChaletsCard(
                                      onHeartTap: () {
                                        HomeTabCubit.get(context).addToFav(
                                          HomeTabCubit.get(context)
                                              .chalets[index]
                                              .id,
                                        );
                                      },
                                      chalet: HomeTabCubit.get(context)
                                          .chalets[index],
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 10.w),
                                  itemCount:
                                      HomeTabCubit.get(context).chalets.length,
                                );
                              } else {
                                return Center(
                                    child: Text("Something went wrong".tr()));
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  "عروض خاصة",
                                  style: TextStyles.poppins18w500(
                                    weight: FontWeight.w700,
                                    color: AppColors.onboardDarkBlue,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Text(
                                  "View more".tr(),
                                  style: TextStyles.poppins14w500(
                                      color: AppColors.darkGreen),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 130.h,
                          child: BlocBuilder<HomeTabCubit, HomeTabState>(
                            builder:
                                (BuildContext context, HomeTabState state) {
                              if (state is HomeTabGetChaletsLoading) {
                                return ListView.separated(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        const ShimmerChaletsSpotCard(),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 10.w),
                                    itemCount: 4);
                              } else if (state is HomeTabGetChaletsSuccess ||
                                  HomeTabCubit.get(context)
                                      .chalets
                                      .isNotEmpty) {
                                return ListView.separated(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      ChaletsSpotCard(
                                    chalet: HomeTabCubit.get(context)
                                        .chalets[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 10.w),
                                  itemCount:
                                      HomeTabCubit.get(context).chalets.length,
                                );
                              } else {
                                return Center(
                                    child: Text("Something went wrong".tr()));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
