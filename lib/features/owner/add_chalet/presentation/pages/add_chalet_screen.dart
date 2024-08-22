import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/app_icons.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/owner/add_chalet/data/data_sources/add_chalet_dto.dart';
import 'package:chalet_spot/features/owner/add_chalet/presentation/manager/add_chalet_cubit.dart';
import 'package:chalet_spot/features/owner/add_chalet/presentation/manager/add_chalet_state.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/api/dio_consumer.dart';
import '../../../../../core/utils/text_styles.dart';
import '../widgets/add_chalet_details.dart';

class AddChaletScreen extends StatelessWidget {
  const AddChaletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddChaletCubit(AddChaletRemoteDto(DioConsumer(dio: Dio()))),
      child: BlocConsumer<AddChaletCubit, AddChaletState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: getAppBar(
              context,
              "أضف شالية",
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: AddChaletCubit.get(context).addChaletFormKey,
                    autovalidateMode:
                        AddChaletCubit.get(context).autoValidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.house,
                              height: 100.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: AddChaletDetails(
                                title: 'الأسم',
                                child: TextFieldDetails(
                                  hintText: 'أضف اسم الشالية',
                                  controller: AddChaletCubit.get(context)
                                      .nameController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AddChaletDetails(
                          title: 'الوصف',
                          child: TextFieldDetails(
                            hintText: 'وصف الشالية',
                            controller: AddChaletCubit.get(context)
                                .descriptionController,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddChaletDetails(
                          title: 'العنوان',
                          child: TextFieldDetails(
                            hintText: 'عنوان الشالية',
                            controller:
                                AddChaletCubit.get(context).addressController,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddChaletDetails(
                          title: 'المدينة',
                          child: DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // Add more decoration..
                            ),
                            hint: Text(
                              AddChaletCubit.get(context).selectedCityValue,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            items: AddChaletCubit.get(context)
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
                            onChanged: (value) {
                              AddChaletCubit.get(context)
                                  .updateSelectedValue(value);
                            },
                            onSaved: (value) {
                              AddChaletCubit.get(context)
                                  .updateSelectedValue(value);
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
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddChaletDetails(
                          title: 'الأولوية',
                          child: TextFieldDetails(
                            validator:
                                AddChaletCubit.get(context).validateNumber,
                            hintText: 'أضف الأولوية',
                            controller:
                                AddChaletCubit.get(context).priorityController,
                            keyboardTyp: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddChaletDetails(
                          title: 'رابط الفيديو',
                          child: TextFieldDetails(
                            hintText: 'أضف فيديو تعريفي عن الشالية',
                            controller:
                                AddChaletCubit.get(context).videoController,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddChaletDetails(
                          title: 'الحالة',
                          child: TextFieldDetails(
                            hintText: 'أضف حالة الشالية',
                            controller:
                                AddChaletCubit.get(context).stateController,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AddChaletDetails(
                                initiallyExpanded: true,
                                title: 'صباحي',
                                child: TextFieldDetails(
                                  validator: AddChaletCubit.get(context)
                                      .validateNumber,
                                  hintText: 'أضف الصباح',
                                  keyboardTyp: TextInputType.number,
                                  controller: AddChaletCubit.get(context)
                                      .dayPriceController,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: AddChaletDetails(
                                initiallyExpanded: true,
                                title: 'مسائي',
                                child: TextFieldDetails(
                                  validator: AddChaletCubit.get(context)
                                      .validateNumber,
                                  hintText: 'أضف الليالي',
                                  controller: AddChaletCubit.get(context)
                                      .nightPriceController,
                                  keyboardTyp: TextInputType.number,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddChaletDetails(
                          initiallyExpanded: true,
                          title: 'صور الشالية',
                          child: Column(
                            children: [
                              AddChaletCubit.get(context).imgs.isEmpty
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: 50.h,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            Text('صورة ${index + 1}'),
                                            Text(AddChaletCubit.get(context)
                                                .imgs[index]
                                                .img!),
                                          ],
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 10),
                                        // Adjust the width as needed
                                        itemCount: AddChaletCubit.get(context)
                                            .imgs
                                            .length,
                                      ),
                                    ),
                              TextFieldDetails(
                                validator: (value) {
                                  return null;
                                },
                                hintText: 'أضف رابط الصورة',
                                controller:
                                    AddChaletCubit.get(context).imgController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              MyButton(
                                color: AppColors.onboardDarkBlue,
                                textColor: AppColors.lightGreen,
                                onPressed: () {
                                  AddChaletCubit.get(context).addImage();
                                  AddChaletCubit.get(context)
                                      .imgController
                                      .clear();
                                },
                                text: "إضافة",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddChaletDetails(
                          initiallyExpanded: true,
                          title: 'المميزات',
                          child: SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemCount: AddChaletCubit.get(context)
                                  .featuresList
                                  .length,
                              itemBuilder: (context, index) {
                                final option = AddChaletCubit.get(context)
                                    .featuresList[index];
                                return CheckboxListTile(
                                  activeColor: AppColors.onboardDarkBlue,
                                  checkColor: AppColors.lightGreen,
                                  title: Text(
                                    option,
                                    style: TextStyles.poppins16w500(),
                                  ),
                                  value: AddChaletCubit.get(context)
                                      .features
                                      .any((e) => e.title == option),
                                  onChanged: (_) {
                                    AddChaletCubit.get(context)
                                        .toggleOption(option);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        MyButton(
                          text: "أضف الشالية",
                          onPressed: () {
                            AddChaletCubit.get(context).addChaletOnPressed(
                                context, const Text("جاري إضافة الشالية"));
                            Future.delayed(
                              const Duration(seconds: 2),
                              () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
