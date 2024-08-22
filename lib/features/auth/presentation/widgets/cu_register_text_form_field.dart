import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class CuRegisterTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int maxLines;

  const CuRegisterTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.sp),
      child: TextFormField(

        maxLines: maxLines,
        cursorColor: AppColors.black,
        validator: validator,
        obscureText: obscureText,
        style: TextStyles.poppins16w500(
            color: AppColors.black, weight: FontWeight.w400),
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightGreyS,
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: TextStyles.poppins16w500(color: AppColors.black),
          border: InputBorder.none,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
