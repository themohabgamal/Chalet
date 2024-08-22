import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_styles.dart';

class AddChaletDetails extends StatelessWidget {
  final String title;

  final Widget child;
  final bool initiallyExpanded;

  const AddChaletDetails({
    super.key,
    this.initiallyExpanded = true,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16.sp)),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        collapsedBackgroundColor: AppColors.lightGreen,
        backgroundColor: AppColors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.sp)),
        ),
        childrenPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        title: Text(
          title,
          style: TextStyles.poppins16w500(),
        ),
        children: [
          child,
        ],
      ),
    );
  }
}

class TextFieldDetails extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardTyp;
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const TextFieldDetails(
      {super.key,
      required this.hintText,
      this.keyboardTyp,
      required this.controller,
      this.onFieldSubmitted,
      this.onSaved,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: AppColors.lightGreyS,
      ),
      child: TextFormField(
        validator: validator ??
            (String? value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        minLines: 1,
        maxLines: 6,
        style: TextStyles.poppins16w500(
            color: AppColors.black, weight: FontWeight.w400),
        controller: controller,
        keyboardType: keyboardTyp,
        decoration: InputDecoration(
          // suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyles.poppins16w500(color: AppColors.lightGreyM),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
