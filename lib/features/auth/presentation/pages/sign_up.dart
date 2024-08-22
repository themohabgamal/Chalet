import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:chalet_spot/features/auth/data/models/reg_response_model.dart';
import 'package:chalet_spot/features/auth/presentation/manager/auth_cubit.dart';
import 'package:chalet_spot/features/auth/presentation/manager/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/Material.dart';
import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/app_images.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/text_styles.dart';
import '../widgets/cu_register_text_form_field.dart';

class SignUp extends StatefulWidget {
  final String? firebaseUid;
  final String? name;
  final String? phone;
  final String? email;

  const SignUp(
      {super.key, this.firebaseUid, this.name, this.phone, this.email});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordSecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRemoteDto(DioConsumer(dio: Dio()))),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.failures.message,
                  // style: roboto16(
                  //   color: Colors.white,
                  // ),
                ),
              ),
            );
          } else if (state is AuthRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Success'.tr(),
                  // style: roboto16(
                  //   color: Colors.white,
                  // ),
                ),
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (routes) => false,
              // arguments: state.registerEntity.user,
            );
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
              autovalidateMode: AuthCubit.get(context).autoValidateMode,
              key: AuthCubit.get(context).registerFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Let’s get you Signed Up!".tr(),
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
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: MediaWidget(
                        //         onTap: () {
                        //           AuthCubit.get(context)
                        //               .loginWithGoogle(context);
                        //         },
                        //         mediaImg: AppIcons.google,
                        //         mediaName: 'Google',
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 15.w,
                        //     ),
                        //     const Expanded(
                        //       child: MediaWidget(
                        //         mediaImg: AppIcons.facebook,
                        //         mediaName: 'Facebook',
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // Row(
                        //   children: [
                        //     const Expanded(child: Divider()),
                        //     SizedBox(
                        //       width: 15.w,
                        //     ),
                        //     Text(
                        //       "Or Sign Up Using".tr(),
                        //       style: TextStyles.poppins14w500(
                        //         color: AppColors.black,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 15.w,
                        //     ),
                        //     const Expanded(child: Divider()),
                        //   ],
                        // ),
                        SizedBox(
                          height: 30.h,
                        ),
                        widget.name != null
                            ? const SizedBox()
                            : CuRegisterTextFormField(
                                validator: (value) =>
                                    AuthCubit.get(context).validateName(value),
                                controller:
                                    AuthCubit.get(context).nameRegController,
                                labelText: 'Name'.tr(),
                              ),
                        SizedBox(
                          height: widget.name != null ? 0 : 15.h,
                        ),
                        CuRegisterTextFormField(
                          validator: (value) =>
                              AuthCubit.get(context).validateName(value),
                          controller:
                              AuthCubit.get(context).userNameRegController,
                          labelText: 'User Name'.tr(),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        widget.email != null
                            ? const SizedBox()
                            : CuRegisterTextFormField(
                                validator: (value) =>
                                    AuthCubit.get(context).validateEmail(value),
                                controller:
                                    AuthCubit.get(context).emailRegController,
                                labelText: 'Email Address'.tr(),
                                keyboardType: TextInputType.emailAddress,
                              ),
                        SizedBox(
                          height: widget.email != null ? 0 : 15.h,
                        ),
                        CuRegisterTextFormField(
                          validator: (value) =>
                              AuthCubit.get(context).validatePassword(value),
                          controller:
                              AuthCubit.get(context).passwordRegController,
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
                        SizedBox(
                          height: 15.h,
                        ),
                        widget.email != null
                            ? const SizedBox()
                            : CuRegisterTextFormField(
                                controller:
                                    AuthCubit.get(context).phoneRegController,
                                labelText: 'Phone Number'.tr(),
                                keyboardType: TextInputType.number,
                              ),
                        SizedBox(
                          height: 15.h,
                        ),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // Add more decoration..
                          ),
                          hint: Text(
                            'Select Your City'.tr(),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          items: AuthCubit.get(context)
                              .cities
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select City.'.tr();
                            }
                            return null;
                          },
                          onChanged: (value) {
                            AuthCubit.get(context).updateSelectedValue(value);
                          },
                          onSaved: (value) {
                            AuthCubit.get(context).updateSelectedValue(value);
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    MyButton(
                      text: "Sign Up".tr(),
                      onPressed: () {
                        AuthCubit.get(context).signUpOnPressed(
                            context,
                            Text(
                              'Processing Data'.tr(),
                            ),
                            widget.firebaseUid,
                            UserModel(
                              name: widget.name,
                              phone: widget.phone,
                              email: widget.email,
                            ));
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
