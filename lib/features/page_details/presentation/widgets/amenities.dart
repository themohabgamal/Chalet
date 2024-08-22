import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class AmenitiesCard extends StatelessWidget {
  final String assetName;
  final bool isPng;
  final String amenityName;

  const AmenitiesCard(
      {super.key,
      required this.assetName,
      required this.amenityName,
      this.isPng = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: isPng ? 65.w : 50.w,
          height: isPng ? 65.w : 50.h,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEFF),
            borderRadius: BorderRadius.all(
              Radius.circular(
                8.sp,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: isPng
              ? Image.asset(
                  assetName,
                  width: 40.w,
                  height: 40.h,
                )
              : SvgPicture.asset(
                  assetName,
                  width: 32.w,
                  height: 32.h,
                ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          amenityName.tr(),
          style: TextStyles.poppins12w500(
            weight: FontWeight.w400,
            color: AppColors.black,
          ),
        )
      ],
    );
  }
}
