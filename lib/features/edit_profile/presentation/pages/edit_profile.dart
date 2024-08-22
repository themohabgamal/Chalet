import 'package:chalet_spot/config/routes/routes.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/features/edit_profile/presentation/manager/edit_profile_cubit.dart';
import 'package:chalet_spot/features/edit_profile/presentation/manager/edit_profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../core/utils/components.dart';
import '../../../auth/data/models/reg_response_model.dart';
import '../../../auth/presentation/widgets/cu_login_text_form_field.dart';
import '../../data/data_sources/edit_profile_data_sources.dart';

class EditProfile extends StatelessWidget {
  final UserModel user;

  const EditProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(
        EditProfileRemoteDto(DioConsumer(dio: Dio())),
        user.name!,
        user.email!,
      ),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Changed"),
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (route) => false,
            );
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Edit Profile",
              style: TextStyles.poppins16w500(
                weight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SizedBox(
                        height: 300.h,
                        child: Column(
                          children: [
                            SizedBox(
                                height: 200.h,
                                width: double.infinity,
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    'https://i.pinimg.com/564x/f4/20/9d/f4209d9648766c06a998b9ca6d53c300.jpg')),
                          ],
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * .32,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 75.sp,
                          child: CircleAvatar(
                            backgroundImage: const NetworkImage(
                              'https://i.pinimg.com/564x/5e/c5/07/5ec507d7c25f6ddb1f82e6976696807b.jpg',
                            ),
                            radius: 70.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Form(
                      key: EditProfileCubit.get(context).editFormKey,
                      autovalidateMode:
                          EditProfileCubit.get(context).autoValidateMode,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          CuTextFormField(
                            controller:
                                EditProfileCubit.get(context).nameController,
                            validator: (value) => EditProfileCubit.get(context)
                                .validateName(value),
                            labelText: 'Name',
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CuTextFormField(
                            controller:
                                EditProfileCubit.get(context).emailController,
                            validator: (value) => EditProfileCubit.get(context)
                                .validateName(value),
                            labelText: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          MyButton(
                            text: "Save Changes",
                            onPressed: () {
                              EditProfileCubit.get(context)
                                  .saveChangesOnPressed(
                                      context, const Text("processing data"));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
