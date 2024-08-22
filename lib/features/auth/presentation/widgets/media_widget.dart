import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class MediaWidget extends StatelessWidget {
  final String mediaImg;
  final String mediaName;
  final Function()? onTap;

  const MediaWidget(
      {super.key, required this.mediaImg, required this.mediaName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.sp,
            ),
          ),
          border: Border.all(
            color: AppColors.lightGrey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset(
                mediaImg,
                fit: BoxFit.cover,
                height: 24.h,
                width: 24.w,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              mediaName,
              style: TextStyles.poppins16w500(),
            ),
          ],
        ),
      ),
    );
  }
}
