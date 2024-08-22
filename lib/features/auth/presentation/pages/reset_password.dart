import 'package:chalet_spot/config/routes/routes.dart';
import 'package:flutter/Material.dart';
import 'package:chalet_spot/core/utils/app_images.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/text_styles.dart';
import '../widgets/cu_register_text_form_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          "Forgot Password".tr(),
          style: TextStyles.appBarTitle(),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: 118.w,
                    height: 41.h,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    "Let’s Reset your Password!".tr(),
                    style: TextStyles.poppins24w700(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Enter your new Password".tr(),
                    style: TextStyles.poppins14w500(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                   CuRegisterTextFormField(
                    labelText: 'Enter your new Password'.tr(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CuRegisterTextFormField(
                    labelText: 'Confirm your new Password'.tr(),
                  ),
                ],
              ),
              MyButton(
                text: "Reset Password".tr(),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
