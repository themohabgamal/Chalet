import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_styles.dart';

class ShowChaletDetails extends StatelessWidget {
  final String title;

  final bool isFeature;
  final Widget child;
  final bool initiallyExpanded;

  const ShowChaletDetails({
    this.isFeature = false,
    super.key,
    this.initiallyExpanded = true,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(
          16.sp,
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        collapsedBackgroundColor: AppColors.lightGreen,
        backgroundColor: AppColors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.sp,
            ),
          ),
        ),
        childrenPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        title: Text(
          title,
          style: TextStyles.poppins16w500(),
        ),
        children: [
          !isFeature
              ? Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: AppColors.lightGreyS,
                  ),
                  child: child,
                )
              : child,
        ],
      ),
    );
  }
}
