import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class CustomCalendarWidget extends StatelessWidget {
  final List<DateTime?> value;
  final Function(List<DateTime?>) onValueChanged;
  final List<DateTime> disabledDates;

  const CustomCalendarWidget({
    super.key,
    required this.value,
    required this.onValueChanged,
    required this.disabledDates,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: CalendarDatePicker2WithActionButtons(
        config: CalendarDatePicker2WithActionButtonsConfig(
          buttonPadding: EdgeInsets.symmetric(horizontal: 2.w),
          okButton: Container(
            width: 150.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              border: Border.all(color: AppColors.lightGreen),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.sp,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Center(
              child: Text(
                'confirm'.tr(),
                style: TextStyles.poppins20(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          cancelButton: Container(
            height: 50.h,
            width: 120.w,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.lightGreen),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.sp,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Center(
              child: Text(
                'Cancel'.tr(),
                style: TextStyles.poppins20(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          daySplashColor: AppColors.lightGreen,
          okButtonTextStyle: const TextStyle(color: AppColors.black),
          todayTextStyle: const TextStyle(color: AppColors.black),
          cancelButtonTextStyle: const TextStyle(color: AppColors.black),
          firstDate: DateTime.now(),
          calendarType: CalendarDatePicker2Type.range,
          selectedDayTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          selectedDayHighlightColor: AppColors.lightGreen,
          centerAlignModePicker: true,
          customModePickerIcon: const SizedBox(),
          gapBetweenCalendarAndButtons: 0,
          selectableDayPredicate: (date) {
            return !disabledDates.contains(date);
          },
        ),
        value: value,
        onValueChanged: onValueChanged,
      ),
    );
  }
}
