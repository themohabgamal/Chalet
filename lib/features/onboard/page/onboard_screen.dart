import 'package:chalet_spot/core/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/components.dart';
import '../../../core/utils/text_styles.dart';
import '../../../main_cubit/main_cubit.dart';
import '../../../main_cubit/main_state.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 140.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppImages.logo,
                      fit: BoxFit.fill,
                      width: 200.w,
                      height: 70.h,
                    ),
                    SizedBox(
                      width: 180.w,
                      height: 180.h,
                      child: Image.asset(
                        fit: BoxFit.fill,
                        MainCubit.get(context)
                                .onboardList[MainCubit.get(context).counter]
                            ["image"]!,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          MainCubit.get(context)
                              .onboardList[MainCubit.get(context).counter]
                                  ["title"]!
                              .tr(),
                          style: TextStyles.poppins28(),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          MainCubit.get(context)
                              .onboardList[MainCubit.get(context).counter]
                                  ["description"]!
                              .tr(),
                          style: TextStyles.poppins20(color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          MainCubit.get(context).onboardList.length,
                          (index) => Container(
                                width: 9.w,
                                height: 7.h,
                                margin: EdgeInsets.symmetric(horizontal: 6.w),
                                decoration: BoxDecoration(
                                  color: MainCubit.get(context).counter >= index
                                      ? AppColors.lightGreen
                                      : AppColors.lightGrey,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                              )),
                    ),
                    Container(
                      width: 51.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: AppColors.dividerColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                      ),
                    ),
                    MyButton(
                      text: MainCubit.get(context).counter ==
                              MainCubit.get(context).onboardList.length - 1
                          ? "finish"
                          : "next",
                      onPressed: () {
                        MainCubit.get(context).onNextButton(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
