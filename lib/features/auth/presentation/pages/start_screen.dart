import 'package:chalet_spot/config/routes/routes.dart';
import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/app_icons.dart';
import 'package:chalet_spot/core/utils/app_images.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/api/dio_consumer.dart';
import '../../../../core/utils/text_styles.dart';
import '../../data/data_sources/auth_data_sources.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import '../widgets/media_widget.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AuthCubit(AuthRemoteDto(DioConsumer(dio: Dio()))),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.failures.message,
                ),
              ),
            );
          } else if (state is FirstTimeErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Complete your data'.tr(),
                ),
              ),
            );

            Navigator.pushNamed(context, Routes.signUp, arguments: {
              'firebaseUid': state.firebaseUid,
              'name': AuthCubit.get(context).nameRegController.text,
              'email': AuthCubit.get(context).emailRegController.text,
              'phone': AuthCubit.get(context).phoneRegController.text,
            });
          }
        },
        builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: MyAppBar(
            centerTitle: false,
            title: Image.asset(
              AppImages.logo,
              width: 118.w,
              height: 41.h,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            child: SizedBox(
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let’s get you Started!".tr(),
                        style: TextStyles.poppins24w700(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MediaWidget(
                              onTap: () {
                                AuthCubit.get(context).loginWithGoogle(context);
                              },
                              mediaImg: AppIcons.google,
                              mediaName: 'Google',
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          const Expanded(
                            child: MediaWidget(
                              mediaImg: AppIcons.facebook,
                              mediaName: 'Facebook',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      MyButton(
                        text: "Login".tr(),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.login,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      MyButton(
                        text: "Sign Up".tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.signUp,
                              arguments: {
                                'firebaseUid': null,
                                'name': null,
                                'email': null,
                                'phone': null,
                              });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "or".tr(),
                          style:
                              TextStyles.poppins14w500(color: AppColors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushReplacementNamed(
                            //   context,
                            //   Routes.home,
                            // );
                          },
                          child: Text(
                            "Continue as a guest".tr(),
                            style: TextStyles.poppins16w500(
                                    weight: FontWeight.w600)
                                .copyWith(
                              shadows: [
                                const Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
