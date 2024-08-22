import 'package:chalet_spot/config/routes/routes.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/text_styles.dart';

class AdminChaletCard extends StatelessWidget {
  final String chaletId;
  final String chaletName;
  final String chaletCity;
  final Function()? onTrashTap;
  final Function()? onEditTap;

  const AdminChaletCard({
    super.key,
    required this.chaletId,
    required this.chaletName,
    required this.chaletCity,
    this.onTrashTap,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.ownerSingleChalet,
            arguments: chaletId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.all(Radius.circular(12.sp))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppIcons.house),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        chaletName,
                        style: TextStyles.poppins16w500(
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        chaletCity,
                        style: TextStyles.poppins14w500(
                          color: AppColors.darkGreyM,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: onEditTap,
                  child: SvgPicture.asset(AppIcons.editA),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: onTrashTap,
                  child: SvgPicture.asset(AppIcons.trash),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
