import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardImage extends StatelessWidget {
  final String onboardImg;

  const OnboardImage({super.key, required this.onboardImg});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      onboardImg,
      color: Colors.red,
      height: 25.h,
    );
  }
}
