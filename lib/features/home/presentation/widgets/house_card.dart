import 'package:cached_network_image/cached_network_image.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/home/data/models/chalet_model_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/text_styles.dart';

class HouseCard extends StatelessWidget {
  final ChaletModel chaletModel;

  const HouseCard({
    super.key,
    required this.chaletModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.pageDetails,
            arguments: chaletModel.id);
      },
      child: Card(
        elevation: 10,
        shadowColor: AppColors.lightGreyS,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.sp),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: chaletModel.imgs.isEmpty
                            ? AppStrings.noImage
                            : chaletModel.imgs[0].img!,
                        height: 180.h,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            ShimmerWidget(height: 180.h),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
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
                      child: chaletModel.favorites.length == 1
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
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 30.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => SvgPicture.asset(
                              AppIcons.star,
                              width: 16.w,
                              height: 16.h,
                              color: index >= 4 ? AppColors.lightGreyS : null,
                            ),
                            separatorBuilder: (context, state) => SizedBox(
                              width: 2.w,
                            ),
                            itemCount: 5,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        SizedBox(
                          width: 140.w,
                          child: Row(
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                "4.0 ( ${chaletModel.reviews.length} ",
                                style: TextStyles.poppins12w500(),
                              ),
                              SizedBox(
                                width: 45.w,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  "Reviews".tr(),
                                  style: TextStyles.poppins12w500(),
                                ),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                ")",
                                style: TextStyles.poppins12w500(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 235.w,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        chaletModel.name,
                        style: TextStyles.poppins14(
                          color: AppColors.black,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Image.asset(AppImages.locationIcon),
                        SizedBox(
                          width: 5.w,
                        ),
                        SizedBox(
                          width: 210.w,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            chaletModel.city,
                            style: TextStyles.poppins12w500(
                              color: AppColors.darkGreyM,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: 235.w,
                      child: SizedBox(
                        height: 28.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            chaletModel.prices.isEmpty
                                ? const SizedBox()
                                : Flexible(
                                    fit: FlexFit.tight,
                                    child: Row(
                                      children: [
                                        Text(
                                          "\$${chaletModel.prices[0].price}",
                                          style: TextStyles.poppins20(
                                                  weight: FontWeight.w600)
                                              .copyWith(
                                            decorationThickness: 3,
                                            decoration: chaletModel.prices[0]
                                                        .hasDiscount ==
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
                            chaletModel.prices.isEmpty
                                ? const SizedBox()
                                : chaletModel.prices[0].hasDiscount == true
                                    ? Flexible(
                                        fit: FlexFit.tight,
                                        child: Row(
                                          children: [
                                            Text(
                                              "\$${chaletModel.prices[0].price - (chaletModel.prices[0].price * (chaletModel.prices[0].discountAmount!.toDouble() / 100))}",
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerHouseCard extends StatelessWidget {
  const ShimmerHouseCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: AppColors.lightGreyS,
      child: Container(
        width: 260.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sp),
              ),
              child: ShimmerWidget(
                height: 180.h,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => SvgPicture.asset(
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
                    SizedBox(
                      width: 8.w,
                    ),
                    SizedBox(width: 140.w, child: const ShimmerWidget()),
                  ],
                ),
                SizedBox(
                  width: 200.w,
                  child: const ShimmerWidget(),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Image.asset(AppImages.locationIcon),
                    SizedBox(
                      width: 5.w,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: const ShimmerWidget(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(width: 100.w, child: const ShimmerWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
