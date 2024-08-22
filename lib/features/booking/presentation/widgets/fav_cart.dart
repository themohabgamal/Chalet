import 'package:cached_network_image/cached_network_image.dart';
import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/core/utils/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/app_images.dart';

class FavCard extends StatelessWidget {
  final String bookingId;
  final String bookingDate;
  final String image;
  final String title;
  final String location;
  final int totalReviews;
  final int rate;

  const FavCard(
      {super.key,
      required this.bookingId,
      required this.bookingDate,
      required this.image,
      required this.title,
      required this.location,
      required this.totalReviews,
      required this.rate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Card(
        elevation: 1.h,
        shadowColor: const Color(0x74FFFFFF),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.sp,
              ),
            ),
            border: Border.all(color: const Color(0x1A9D9EA6), width: 1),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Booking ID: ".tr(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.poppins14(
                          color: AppColors.black,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      flex: 3,
                      child: Text(
                        bookingId,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.poppins14(
                          color: AppColors.black,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Booking Date: ".tr(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.poppins12w500(
                          color: AppColors.darkGreyM,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      flex: 3,
                      child: Text(
                        bookingDate,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.poppins12w500(
                          color: AppColors.darkGreyM,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 95.h,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            ShimmerWidget(height: 200.h),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 40.h,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      SvgPicture.asset(
                                    AppIcons.star,
                                    width: 16.w,
                                    height: 16.h,
                                    color: index >= rate
                                        ? AppColors.lightGreyS
                                        : null,
                                  ),
                                  separatorBuilder: (context, state) =>
                                      SizedBox(
                                    width: 2.w,
                                  ),
                                  itemCount: 5,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  "$rate.0 ($totalReviews ${"Reviews".tr()})",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyles.poppins12w500(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyles.poppins14(
                              color: AppColors.black,
                              weight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Image.asset(AppImages.locationIcon),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  location,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyles.poppins16w500(
                                    color: AppColors.darkGreyM,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightGreyS,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.sp)),
                          ),
                        ),
                        child: Text(
                          "Cancel".tr(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyles.poppins14(),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.pageDetails);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.sp)),
                          ),
                        ),
                        child: Text(
                          "View Details".tr(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyles.poppins14(
                            weight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerFavCard extends StatelessWidget {
  const ShimmerFavCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Card(
        elevation: 1.h,
        shadowColor: const Color(0x74FFFFFF),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.sp,
              ),
            ),
            border: Border.all(color: const Color(0x1A9D9EA6), width: 1),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Booking ID: ".tr(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyles.poppins14(
                        color: AppColors.black,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: ShimmerWidget(),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Booking Date: ".tr(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyles.poppins12w500(
                        color: AppColors.darkGreyM,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: ShimmerWidget(),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    child: ShimmerWidget(width: 95.w, height: 95.h),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40.h,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    SvgPicture.asset(
                                  AppIcons.star,
                                  width: 16.w,
                                  height: 16.h,
                                  color: AppColors.lightGreyS,
                                ),
                                separatorBuilder: (context, state) => SizedBox(
                                  width: 2.w,
                                ),
                                itemCount: 5,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: ShimmerWidget(),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        ShimmerWidget(),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Image.asset(AppImages.locationIcon),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: ShimmerWidget(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: const Color(0x1A9D9EA6),
                        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                      ),
                      child: ShimmerWidget(),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                      ),
                      child: ShimmerWidget(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
