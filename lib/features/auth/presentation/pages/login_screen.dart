import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/app_icons.dart';
import 'package:chalet_spot/core/utils/app_images.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:chalet_spot/features/auth/presentation/manager/auth_cubit.dart';
import 'package:chalet_spot/features/auth/presentation/manager/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/text_styles.dart';
import '../widgets/cu_login_text_form_field.dart';
import '../widgets/media_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordSecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AuthCubit(AuthRemoteDto(DioConsumer(dio: Dio()))),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.onboardDarkBlue,
                content: Text(
                  'تسجيل دخول ناجح'.tr(),
                  style:
                      TextStyles.poppins16w500().copyWith(color: Colors.white),
                ),
              ),
            );

            // Save token and name in cache
            CacheHelper.saveData(key: 'token', value: state.token);
            CacheHelper.saveData(key: 'name', value: state.name);
            CacheHelper.saveData(key: 'role', value: state.role);

            // Navigate based on role
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(
                context,
                state.role == 'CHALET_OWNER' ? Routes.ownerHome : Routes.home,
                arguments: state,
              );
            });
          } else if (state is AuthLoginError) {
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
            child: Form(
              key: AuthCubit.get(context).loginFormKey,
              autovalidateMode: AuthCubit.get(context).autoValidateMode,
              child: SizedBox(
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let’s get you Logged in!".tr(),
                            style: TextStyles.poppins24w700(),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Enter your information below".tr(),
                            style: TextStyles.poppins14w500(),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: MediaWidget(
                                      onTap: () {
                                        AuthCubit.get(context)
                                            .loginWithGoogle(context);
                                      },
                                      mediaImg: AppIcons.google,
                                      mediaName: 'Google',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Expanded(
                                    child: MediaWidget(
                                      onTap: () {},
                                      mediaImg: AppIcons.facebook,
                                      mediaName: 'Facebook',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                children: [
                                  const Expanded(child: Divider()),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    "Or login with".tr(),
                                    style: TextStyles.poppins14w500(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  const Expanded(child: Divider()),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              CuTextFormField(
                                controller:
                                    AuthCubit.get(context).userNameController,
                                validator: (value) => AuthCubit.get(context)
                                    .validateGeneral(value),
                                labelText: 'User Name'.tr(),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              CuTextFormField(
                                controller:
                                    AuthCubit.get(context).passwordController,
                                validator: (value) => AuthCubit.get(context)
                                    .validatePassword(value),
                                obscureText: isPasswordSecure,
                                labelText: 'Password'.tr(),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordSecure = !isPasswordSecure;
                                      });
                                    },
                                    child: Icon(
                                      isPasswordSecure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                        overlayColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.transparent),
                                        padding: WidgetStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          const EdgeInsets.all(0.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.forgetPassword);
                                      },
                                      child: Text(
                                        "Forgot Password?".tr(),
                                        style: TextStyles.poppins14w500(
                                            color: AppColors.black),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ]),
                              MyButton(
                                text: "Login".tr(),
                                onPressed: () {
                                  AuthCubit.get(context).loginUpOnPressed(
                                    context,
                                    Text(
                                      ''.tr(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account? ".tr(),
                            style: TextStyles.poppins14w500(
                                color: AppColors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.signUp,
                                  arguments: {
                                    'firebaseUid': null,
                                    'name': null,
                                    'email': null,
                                    'phone': null,
                                  });
                            },
                            child: Text(
                              "Register Now".tr(),
                              style:
                                  TextStyles.poppins20(weight: FontWeight.w900)
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
                            height: 20.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "or".tr(),
                                style: TextStyles.poppins14w500(
                                  color: AppColors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //   context,
                                  //   Routes.home,
                                  //   (Route<dynamic> route) => false,
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
                        ],
                      ),
                    )
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
