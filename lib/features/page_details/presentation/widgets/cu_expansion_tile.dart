import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class CuExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const CuExpansionTile(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: const Color(0xFFEEEEFF),
      collapsedShape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.sp))),
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.sp))),
      backgroundColor: const Color(0xFFEEEEFF),
      title: Text(
        title,
        style: TextStyles.poppins18w500(
          weight: FontWeight.w700,
          color: AppColors.onboardDarkBlue,
        ),
      ),
      children: children,
    );
  }
}
