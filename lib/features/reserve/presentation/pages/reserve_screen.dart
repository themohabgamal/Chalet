import 'package:chalet_spot/config/routes/routes.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/auth/presentation/widgets/cu_register_text_form_field.dart';
import 'package:chalet_spot/features/reserve/data/data_sources/reserve_dto.dart';
import 'package:chalet_spot/features/reserve/data/models/reserve_model.dart';
import 'package:chalet_spot/features/reserve/presentation/manager/reserve_cubit.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/text_styles.dart';
import '../manager/reserve_state.dart';

class ReserveScreen extends StatelessWidget {
  final String chaletId;
  final String stayType;
  final String startDate;
  final String endDate;

  const ReserveScreen(
      {super.key,
      required this.chaletId,
      required this.stayType,
      required this.startDate,
      required this.endDate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReserveCubit(RemoteReserveDto(DioConsumer(dio: Dio()))),
      child: BlocConsumer<ReserveCubit, ReserveState>(
        listener: (context, state) {
          if (state is ReserveError) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        "خطأ",
                        style: TextStyles.poppins24w700(),
                      ),
                      content: Text(
                        textAlign: TextAlign.center,
                        state.failures.message,
                        style: TextStyles.poppins18w500(),
                      ),
                    ));
          } else if (state is ReserveSuccess) {
            Navigator.pushReplacementNamed(context, Routes.home);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(
                  textAlign: TextAlign.center,
                  state.msg,
                  style: TextStyles.poppins18w500(),
                ),
              ),
            );
          }
        },
        builder: (BuildContext context, ReserveState state) => Scaffold(
          appBar: AppBar(
            title: Text(
              "Reserve".tr(),
              style: TextStyles.appBarTitle(),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CuRegisterTextFormField(
                  labelText: 'Code'.tr(),
                  controller: ReserveCubit.get(context).codeController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height:
                      state is ReserveCodeError || state is ReserveCodeSuccess
                          ? 10.h
                          : 0,
                ),
                state is ReserveCodeSuccess
                    ? Text(
                        state.msg,
                        style: TextStyles.appBarTitle(),
                      )
                    : state is ReserveCodeError
                        ? Text(
                            state.failures.message,
                            style:
                                TextStyles.poppins14w500(color: AppColors.red),
                          )
                        : const SizedBox(),
                SizedBox(
                  height:
                      state is ReserveCodeError || state is ReserveCodeSuccess
                          ? 10.h
                          : 0,
                ),
                SizedBox(
                  width: 200.w,
                  child: state is ReserveCodeLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.lightGreen,
                        ))
                      : MyButton(
                          text: 'apply'.tr(),
                          onPressed: () {
                            ReserveCubit.get(context).addCode();
                          },
                        ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CuRegisterTextFormField(
                  maxLines: 5,
                  labelText: 'Comments'.tr(),
                  controller: ReserveCubit.get(context).commentController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                MyButton(
                  text: "confirm".tr(),
                  onPressed: () {
                    ReserveCubit.get(context).addReserve(
                      ReserveModel(
                        stayType: stayType,
                        startDate: DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(startDate)),
                        endDate: DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(endDate)),
                        comment: "",
                        code: "",
                        chaletId: chaletId,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
