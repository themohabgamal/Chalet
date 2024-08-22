import 'package:chalet_spot/core/utils/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'app_colors.dart';
import 'app_icons.dart';

Widget unDefineRoute() => const Scaffold(
      body: Center(
        child: Text("UnDefine Route"),
      ),
    );

class MyButton extends StatelessWidget {
  final Color color;
  final TextStyle? style;
  final String text;
  final Color? textColor;
  final Color borderColor;
  final double? height;
  final double? width;

  final Function()? onPressed;

  const MyButton(
      {required this.text,
      this.color = AppColors.lightGreen,
      this.borderColor = AppColors.lightGreen,
      this.style,
      this.textColor,
      this.onPressed,
      super.key,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 56.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(14.sp)),
          ),
        ),
        child: Text(
          text.tr(),
          style: TextStyles.poppins20(color: textColor ?? AppColors.darkBlue),
        ),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final int notificationCount;

  const NotificationIcon({
    required this.notificationCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool showCounter = notificationCount > 0;

    return showCounter
        ? badges.Badge(
            position: badges.BadgePosition.topEnd(
              top: 8.h,
              end: 12.w,
            ),
            badgeAnimation: const badges.BadgeAnimation.slide(
              curve: Curves.decelerate,
            ),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: AppColors.red,
              // borderSide: BorderSide(color: Colors.white, width: 3.w),
            ),
            badgeContent: const SizedBox(),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons.notification,
                height: 25.h,
              ),
            ),
          )
        : IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppIcons.notification,
              height: 20.h,
            ),
          );
  }
}

AppBar getAppBar(BuildContext context, String title) {
  return AppBar(
    elevation: 10,
    leadingWidth: 70.w,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              12.sp,
            ),
          ),
          border: Border.all(
            color: AppColors.lightGrey,
          ),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.onboardDarkBlue,
        ),
      ),
    ),
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: TextStyles.poppins26(
        weight: FontWeight.w600,
      ),
    ),
    centerTitle: false,
  );
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final bool? centerTitle;
  final List<Widget>? actions;

  const MyAppBar(
      {super.key,
      required this.title,
      this.centerTitle,
      this.actions,
      this.leading});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      actions: actions,
      iconTheme: const IconThemeData(color: AppColors.black),
      centerTitle: centerTitle,
      title: title,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.transparent,
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double? width;

  const ShimmerWidget({super.key, this.height = 10, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height.h,
        color: Colors.white,
      ),
    );
  }
}
