import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class StrokeText extends StatelessWidget {
  final String text;

  const StrokeText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 85.w), // Set max width as needed
      child: Text(
        text.tr(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyles.poppins14w500(
          weight: FontWeight.w800,
          color: AppColors.darkBlue,
        ),
      ),
    );
  }
}
