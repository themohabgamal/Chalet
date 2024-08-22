import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class CuTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CuTextFormField(
      {super.key,
      this.controller,
      this.labelText,
      this.keyboardType,
      this.suffixIcon,
      this.obscureText = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.black,
      validator: validator,
      obscureText: obscureText,
      style: TextStyles.poppins16w500(color: AppColors.black),
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.black),
          // Corrected here
          borderRadius: BorderRadius.circular(10.sp),
        ),
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: TextStyles.poppins16w500(color: AppColors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.black),
          // Corrected here
          borderRadius: BorderRadius.circular(10.sp),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.black),
          // Corrected here
          borderRadius: BorderRadius.circular(10.sp),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.black),
          // Corrected here
          borderRadius: BorderRadius.circular(10.sp),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.black),
          // Corrected here
          borderRadius: BorderRadius.circular(10.sp),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
