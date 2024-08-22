import 'package:cached_network_image/cached_network_image.dart';
import 'package:chalet_spot/core/utils/app_icons.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/text_styles.dart';
import '../../data/models/chalet_model_response.dart';

class ChaletsSpotCard extends StatelessWidget {
  final ChaletModel chalet;

  const ChaletsSpotCard({super.key, required this.chalet});

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
          width: 360.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.sp),
            ),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                        child: CachedNetworkImage(
                          imageUrl: chalet.imgs.isEmpty
                              ? AppStrings.noImage
                              : chalet.imgs[0].img!,
                          width: 95.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              ShimmerWidget(height: 100.h),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
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
                                // ),
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
                              height: 20.h,
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
                            //           Navigator.pushNamed(
                            //               context, Routes.pageDetails,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                  decoration: chalet.prices[0]
                                                              .hasDiscount ==
                                                          true
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                                  decorationColor:
                                                      AppColors.red,
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
                                                            weight:
                                                                FontWeight.w600)
                                                        .copyWith(
                                                      decorationThickness: 3,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          AppColors.lightGreen,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    "/night".tr(),
                                                    style: TextStyles
                                                        .poppins16w500(
                                                            weight: FontWeight
                                                                .w800),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerChaletsSpotCard extends StatelessWidget {
  const ShimmerChaletsSpotCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: AppColors.lightGreyS,
      child: Container(
        width: 360.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    child: ShimmerWidget(
                      width: 95.w,
                      height: 100.h,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 190.w,
                            child: const ShimmerWidget(),
                          ),
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22.h,
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
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
