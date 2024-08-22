import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class TextStyles {
  // o n b o a r d    t i t l e
  static TextStyle poppins28(
          {FontWeight? weight = FontWeight.w600,
          Color? color = AppColors.onboardDarkBlue}) =>
      GoogleFonts.poppins(
        fontSize: 28.sp,
        fontWeight: weight,
        color: color,
      );

// o n b o a r d    d e s c r i p t i o n
  static TextStyle poppins14(
          {FontWeight? weight = FontWeight.w400,
          Color? color = AppColors.onboardDarkBlue}) =>
      GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: weight,
        color: color,
      );

  // B u t t o n
  static TextStyle poppins20(
          {FontWeight? weight = FontWeight.w900,
          Color? color = AppColors.darkBlue}) =>
      GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: weight,
        color: color,
      );

  // L o g i n
  static TextStyle poppins24w700(
          {FontWeight? weight = FontWeight.w700,
          Color? color = AppColors.black}) =>
      GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: weight,
        color: color,
      );

  static TextStyle poppins16w500(
          {FontWeight? weight = FontWeight.w500,
          Color? color = AppColors.black}) =>
      GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: weight,
        color: color,
      );

  static TextStyle poppins18w500(
      {FontWeight? weight = FontWeight.w500,
        Color? color = AppColors.black}) =>
      GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: weight,
        color: color,
      );
  static TextStyle poppins14w500(
          {FontWeight? weight = FontWeight.w500,
          Color? color = AppColors.darkGreyM}) =>
      GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: weight,
        color: color,
      );

  static TextStyle poppins12w500(
          {FontWeight? weight = FontWeight.w500,
          Color? color = AppColors.black}) =>
      GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: weight,
        color: color,
      );

  static TextStyle poppins10(
          {FontWeight? weight = FontWeight.w400,
          Color? color = AppColors.darkGreyL}) =>
      GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: weight,
        color: color,
      );


  static TextStyle poppins24(
      {FontWeight? weight = FontWeight.w600,
        Color? color = AppColors.onboardDarkBlue}) =>
      GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: weight,
        color: color,
      );


  static TextStyle poppins26(
      {FontWeight? weight = FontWeight.w600,
        Color? color = AppColors.onboardDarkBlue}) =>
      GoogleFonts.poppins(
        fontSize: 26.sp,
        fontWeight: weight,
        color: color,
      );



  static TextStyle appBarTitle(
      {FontWeight? weight = FontWeight.w700,
        Color? color = AppColors.onboardDarkBlue}) =>
      GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: weight,
        color: color,
      );
}
