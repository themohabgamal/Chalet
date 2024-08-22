import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/text_styles.dart';

class ServicesContainer extends StatelessWidget {
  final String assetName;
  final bool isIncluded;

  const ServicesContainer(
      {super.key, required this.assetName, this.isIncluded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreyS,
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.sp,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Row(
        children: [
          SvgPicture.asset(assetName),
          SizedBox(
            width: 10.w,
          ),
          Text(
            isIncluded ? "Included".tr() : "Not Included".tr(),
            style: TextStyles.poppins14w500(color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
