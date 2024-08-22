import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/text_styles.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SortButton extends StatelessWidget {
  final String title;
  final String iconName;
  final Function()? onTap;

  const SortButton(
      {super.key, required this.title, required this.iconName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.sp,
            ),
          ),
          border: Border.all(color: AppColors.lightGrey, width: 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyles.poppins12w500(),
            ),
            SizedBox(
              width: 5.w,
            ),
            SvgPicture.asset(
              iconName,
            ),
          ],
        ),
      ),
    );
  }
}
