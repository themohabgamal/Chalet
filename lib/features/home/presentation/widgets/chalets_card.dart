import 'package:cached_network_image/cached_network_image.dart';
import 'package:chalet_spot/config/routes/routes.dart';
import 'package:chalet_spot/core/utils/app_icons.dart';
import 'package:chalet_spot/core/utils/app_strings.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/text_styles.dart';
import '../../data/models/chalet_model_response.dart';

class ChaletsCard extends StatelessWidget {
  final ChaletModel chalet;
  final Function()? onHeartTap;

  const ChaletsCard({super.key, required this.chalet, this.onHeartTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.pageDetails, arguments: chalet.id);
      },
      child: Card(
        elevation: 1,
        shadowColor: AppColors.lightGreyS,
        child: Container(
          width: 300.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.sp),
            ),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.sp),
                        topLeft: Radius.circular(10.sp),
                      ),
                      child: CachedNetworkImage(
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: chalet.imgs.isEmpty
                            ? AppStrings.noImage
                            : chalet.imgs[0].img!,
                        placeholder: (context, url) =>
                            ShimmerWidget(height: 200.h),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    GestureDetector(
                      onTap: onHeartTap,
                      child: Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100.sp),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 10.w),
                        child: chalet.favorites.length == 1
                            ? Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  AppIcons.fullHeart,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  AppIcons.heart,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 20.h, top: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              chalet.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyles.poppins16w500(
                                weight: FontWeight.w500,
                                color: AppColors.onboardDarkBlue,
                              ),
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     SvgPicture.asset(AppIcons.star),
                          //     SizedBox(
                          //       width: 10.w,
                          //     ),
                          //     Text(
                          //       "4.0",
                          //       style: TextStyles.poppins12w500(),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Image.asset(AppImages.locationIcon),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              chalet.city,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyles.poppins16w500(
                                color: AppColors.darkGreyM,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      // SizedBox(
                      //   height: 28.h,
                      //   child: Row(
                      //     children: [
                      //       ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //             backgroundColor: AppColors.lightGreen),
                      //         onPressed: () {},
                      //         child: Text(
                      //           "Reviews".tr(),
                      //           style: TextStyles.poppins12w500(),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 8.w,
                      //       ),
                      //       ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //             backgroundColor: AppColors.darkGreyL),
                      //         onPressed: () {
                      //           Navigator.pushNamed(context, Routes.pageDetails,
                      //               arguments: chalet.id);
                      //         },
                      //         child: Text(
                      //           "More info".tr(),
                      //           style: TextStyles.poppins12w500(
                      //               color: Colors.white),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      SizedBox(
                        height: 28.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            chalet.prices.isEmpty
                                ? const SizedBox()
                                : Flexible(
                                    fit: FlexFit.tight,
                                    child: Row(
                                      children: [
                                        Text(
                                          "\$${chalet.prices[0].price}",
                                          style: TextStyles.poppins20(
                                                  weight: FontWeight.w600)
                                              .copyWith(
                                            decorationThickness: 3,
                                            decoration:
                                                chalet.prices[0].hasDiscount ==
                                                        true
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                            decorationColor: AppColors.red,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          "/night".tr(),
                                          style: TextStyles.poppins16w500(
                                              weight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                  ),
                            chalet.prices.isEmpty
                                ? const SizedBox()
                                : chalet.prices[0].hasDiscount == true
                                    ? Flexible(
                                        fit: FlexFit.tight,
                                        child: Row(
                                          children: [
                                            Text(
                                              "\$${chalet.prices[0].price - (chalet.prices[0].price * (chalet.prices[0].discountAmount!.toDouble() / 100))}",
                                              style: TextStyles.poppins20(
                                                      weight: FontWeight.w600)
                                                  .copyWith(
                                                decorationThickness: 3,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    AppColors.lightGreen,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              "/night".tr(),
                                              style: TextStyles.poppins16w500(
                                                  weight: FontWeight.w800),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
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

class ShimmerChaletsCard extends StatelessWidget {
  const ShimmerChaletsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: AppColors.lightGreyS,
      child: Container(
        width: 300.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
              ),
              child: ShimmerWidget(
                height: 200.h,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 180.w, child: const ShimmerWidget()),
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.star),
                          SizedBox(
                            width: 10.w,
                          ),
                          ShimmerWidget(
                            width: 10.w,
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(AppImages.locationIcon),
                      SizedBox(
                        width: 10.w,
                      ),
                      ShimmerWidget(
                        width: 40.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 25.h,
                    child: Row(
                      children: [
                        ShimmerWidget(
                          width: 30.w,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        ShimmerWidget(
                          width: 50.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
