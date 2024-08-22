import 'package:chalet_spot/core/utils/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/page_details/presentation/manager/details_page_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../page_details/data/data_sources/single_chalet_dto.dart';
import '../../../../page_details/presentation/manager/details_page_state.dart';
import '../widgets/show_chalet_details.dart';

class ChaletDetailsScreen extends StatelessWidget {
  final String chaletId;

  const ChaletDetailsScreen({required this.chaletId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsPageCubit(SingleChaletRemoteDto(DioConsumer(dio: Dio())))
            ..getChalet(chaletId),
      child: BlocConsumer<DetailsPageCubit, DetailsPageState>(
          listener: (context, state) => () {},
          builder: (context, state) {
            if (state is GetChaletSuccess) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: getAppBar(
                  context,
                  "Chalet Details",
                ),
                body: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.house,
                                height: 120.h,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.chalet.name ?? "",
                                      style: TextStyles.poppins24(
                                        weight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "Details",
                                      style: TextStyles.poppins16w500(
                                          weight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(
                                      state.chalet.description ?? "",
                                      style: TextStyles.poppins14w500(
                                          weight: FontWeight.normal,
                                          color: AppColors.darkGreyM),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Chalet Details",
                              style: TextStyles.poppins16w500(
                                weight: FontWeight.w800,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ShowChaletDetails(
                            title: 'Description',
                            child: Text(
                              state.chalet.description ?? "",
                              style: TextStyles.poppins16w500(
                                color: AppColors.darkGreyL,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ShowChaletDetails(
                            title: 'Address',
                            child: Text(
                              state.chalet.address ?? "",
                              style: TextStyles.poppins16w500(
                                color: AppColors.darkGreyL,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ShowChaletDetails(
                              title: 'City',
                              child: Text(
                                state.chalet.city ?? "",
                                style: TextStyles.poppins16w500(
                                    color: AppColors.darkGreyL),
                              )),
                          SizedBox(
                            height: 10.h,
                          ),
                          ShowChaletDetails(
                            title: 'Priority',
                            child: Text(
                              state.chalet.priority.toString(),
                              style: TextStyles.poppins16w500(
                                color: AppColors.darkGreyL,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ShowChaletDetails(
                            title: 'Video Url',
                            child: Text(
                              state.chalet.video ?? "",
                              style: TextStyles.poppins16w500(
                                color: AppColors.darkGreyL,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ShowChaletDetails(
                            title: 'State',
                            child: Text(
                              state.chalet.state ?? "",
                              style: TextStyles.poppins16w500(
                                color: AppColors.darkGreyL,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ShowChaletDetails(
                                  title: 'Day Stay',
                                  child: Text(
                                    state.chalet.prices?[1].price.toString() ??
                                        "",
                                    style: TextStyles.poppins16w500(
                                      color: AppColors.darkGreyL,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: ShowChaletDetails(
                                  title: 'Night Stay',
                                  child: Text(
                                    state.chalet.prices?[0].price.toString() ??
                                        "",
                                    style: TextStyles.poppins16w500(
                                      color: AppColors.darkGreyL,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ShowChaletDetails(
                            isFeature: true,
                            title: 'Images',
                            child: SizedBox(
                              height: 20.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 0.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    color: AppColors.lightGreyS,
                                  ),
                                  child: Text(
                                    state.chalet.imgs?[index].img ?? "",
                                    style: TextStyles.poppins16w500(
                                        color: AppColors.darkGreyL),
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10.w,
                                ),
                                itemCount: state.chalet.imgs?.length ?? 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ShowChaletDetails(
                            isFeature: true,
                            title: 'Feature ',
                            child: SizedBox(
                              height: 20.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 0.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    color: AppColors.lightGreyS,
                                  ),
                                  child: Text(
                                    state.chalet.features?[index].title ?? "",
                                    style: TextStyles.poppins16w500(
                                        color: AppColors.darkGreyL),
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10.w,
                                ),
                                itemCount: state.chalet.features?.length ?? 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.lightGreen,
                  ),
                ),
              );
            }
          }),
    );
  }
}
