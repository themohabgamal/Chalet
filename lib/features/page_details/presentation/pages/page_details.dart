import 'package:cached_network_image/cached_network_image.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/page_details/presentation/manager/details_page_cubit.dart';
import 'package:chalet_spot/features/reserve/presentation/pages/reserve_screen.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/text_styles.dart';
import '../../data/data_sources/single_chalet_dto.dart';
import '../manager/details_page_state.dart';
import '../widgets/amenities.dart';
import '../widgets/cu_caledar_widget.dart';
import '../widgets/cu_expansion_tile.dart';
import '../widgets/cu_radio_list_tile.dart';
import '../widgets/services_container.dart';

class PageDetailsScreen extends StatefulWidget {
  final String chaletId;

  const PageDetailsScreen({super.key, required this.chaletId});

  @override
  State<PageDetailsScreen> createState() => _PageDetailsScreenState();
}

class _PageDetailsScreenState extends State<PageDetailsScreen> {
  int _selectedValue = 0;
  List<DateTime?> value = [];
  PageController pageController = PageController();
  int pageView = 0;
  int tappedIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsPageCubit(SingleChaletRemoteDto(DioConsumer(dio: Dio())))
            ..getReservedDates(widget.chaletId)
            ..getChalet(widget.chaletId),
      child: BlocConsumer<DetailsPageCubit, DetailsPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            final chalet = DetailsPageCubit.get(context).chalet;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leadingWidth: 0,
                leading: const SizedBox(),
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                toolbarHeight: 100.h,
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.logo,
                        width: 60.w,
                        height: 21.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppBar(
                        surfaceTintColor: Colors.white,
                        backgroundColor: Colors.white,
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12.sp,
                                ),
                              ),
                              border: Border.all(
                                color: AppColors.lightGrey,
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        title: chalet.id != null
                            ? Text(
                                chalet.name ?? "",
                                style: TextStyles.poppins20(
                                  weight: FontWeight.w800,
                                ),
                              )
                            : ShimmerWidget(
                                height: 15.h,
                                width: 100.w,
                              ),
                        actions: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12.sp,
                                ),
                              ),
                              border: Border.all(
                                color: AppColors.lightGrey,
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: 15.w,
                                top: 10.h,
                                right: 15.w,
                                bottom: 10.h),
                            child: SvgPicture.asset(AppIcons.menu),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.sp),
                          ),
                          child: Stack(
                            children: [
                              chalet.id != null
                                  ? chalet.imgs!.isNotEmpty
                                      ? PageView(
                                          controller: pageController,
                                          onPageChanged: (value) {
                                            setState(() {
                                              pageView = value;
                                            });
                                          },
                                          children: List.generate(
                                            chalet.imgs!.length,
                                            (index) => ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return const LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black38
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ).createShader(bounds);
                                              },
                                              blendMode: BlendMode.darken,
                                              child: CachedNetworkImage(
                                                height: 300.h,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                                imageUrl: chalet.imgs!.isEmpty
                                                    ? AppStrings.noImage
                                                    : chalet.imgs![index].img!,
                                                placeholder: (context, url) =>
                                                    ShimmerWidget(
                                                        height: 200.h),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        )
                                      : CachedNetworkImage(
                                          height: 300.h,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                          imageUrl: AppStrings.noImage,
                                          placeholder: (context, url) =>
                                              ShimmerWidget(height: 200.h),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                  : const ShimmerWidget(
                                      height: double.infinity),
                              chalet.id != null
                                  ? Positioned(
                                      bottom: 0,
                                      right: 0,
                                      height: 140.h,
                                      width: 80.w,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: chalet.imgs!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                tappedIndex = index;
                                              });
                                              if (pageController.hasClients) {
                                                pageController.animateToPage(
                                                  index,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            },
                                            child: Center(
                                              child: AnimatedContainer(
                                                height: 50,
                                                width: 50,
                                                margin: EdgeInsets.only(
                                                    right: 3.w, bottom: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: tappedIndex == index
                                                        ? Colors.yellow
                                                        : Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      chalet.imgs!.isEmpty
                                                          ? AppStrings.noImage
                                                          : chalet.imgs![index]
                                                              .img!,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                transform: Matrix4.identity()
                                                  ..scale(tappedIndex == index
                                                      ? 1.1
                                                      : 1.0),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: ServicesContainer(
                              assetName: AppIcons.wifi,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Expanded(
                            flex: 2,
                            child: ServicesContainer(
                              assetName: AppIcons.coffee,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: chalet.id != null
                                      ? Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          chalet.name ?? "No Name",
                                          style: TextStyles.poppins20(
                                            weight: FontWeight.w700,
                                            color: AppColors.onboardDarkBlue,
                                          ),
                                        )
                                      : ShimmerWidget(
                                          height: 10.h,
                                        ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Reviews".tr(),
                                      style: TextStyles.poppins16w500(
                                          color: AppColors.darkGreen),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        chalet.reviews?.length.toString() ??
                                            '0',
                                        style: TextStyles.poppins12w500(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Image.asset(AppImages.locationIcon),
                                SizedBox(
                                  width: 10.w,
                                ),
                                chalet.id != null
                                    ? Text(
                                        chalet.city ?? "No City",
                                        style: TextStyles.poppins16w500(
                                          color: AppColors.black,
                                        ),
                                      )
                                    : ShimmerWidget(
                                        height: 10.h,
                                        width: 200.w,
                                      )
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              "Description".tr(),
                              style: TextStyles.poppins18w500(
                                weight: FontWeight.w700,
                                color: AppColors.onboardDarkBlue,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            chalet.id != null
                                ? Text(
                                    chalet.description ?? "No Description",
                                    style: TextStyles.poppins16w500(
                                      weight: FontWeight.w400,
                                      color: AppColors.black,
                                    ),
                                  )
                                : ShimmerWidget(
                                    height: 25.h,
                                  ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              "Amenities".tr(),
                              style: TextStyles.poppins18w500(
                                weight: FontWeight.w700,
                                color: AppColors.onboardDarkBlue,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                const AmenitiesCard(
                                  assetName: AppIcons.parking,
                                  amenityName: 'Parking',
                                ),
                                SizedBox(
                                  width: 25.w,
                                ),
                                const AmenitiesCard(
                                  assetName: AppIcons.wifiAme,
                                  amenityName: "wifi",
                                ),
                                SizedBox(
                                  width: 25.w,
                                ),
                                const AmenitiesCard(
                                  assetName: AppIcons.laundry,
                                  amenityName: 'Laundry',
                                ),
                                SizedBox(
                                  width: 25.w,
                                ),
                                const AmenitiesCard(
                                  assetName: AppIcons.ac,
                                  amenityName: 'Ac',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              "Contact".tr(),
                              style: TextStyles.poppins18w500(
                                weight: FontWeight.w700,
                                color: AppColors.onboardDarkBlue,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                try {
                                  DetailsPageCubit.get(context).launchWhatsApp(
                                    phone: '+201097029919',
                                    message: 'Hello from my Flutter app!',
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Failed to launch WhatsApp: $e'),
                                    ),
                                  );
                                }
                              },
                              child: AmenitiesCard(
                                isPng: true,
                                assetName: AppIcons.whatsapp,
                                amenityName: 'Whatsapp'.tr(),
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            CuExpansionTile(
                              title: 'Type of stay'.tr(),
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.sp)),
                                    color: Colors.white,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        CustomRadioListTile(
                                      title:
                                          "${chalet.prices?[index].stayType ?? ""} Price: ${chalet.prices?[index].price ?? ""}",
                                      value: index,
                                      groupValue: _selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedValue = value!;
                                        });
                                      },
                                    ),
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      indent: 50.w,
                                      endIndent: 80.w,
                                    ),
                                    itemCount: chalet.prices?.length ?? 0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CuExpansionTile(
                              title: "reservation_date".tr(),
                              children: [
                                CustomCalendarWidget(
                                  value: value,
                                  onValueChanged: (dates) {
                                    setState(() {
                                      value = dates;
                                    });
                                  },
                                  disabledDates: DetailsPageCubit.get(context)
                                      .disabledDates,
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 25.h),
                              child: SizedBox(
                                width: double.infinity,
                                child: MyButton(
                                  text: 'Book Now'.tr(),
                                  onPressed: () {
                                    if (value.isEmpty) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                  "من فضلك",
                                                  style: TextStyles
                                                      .poppins24w700(),
                                                ),
                                                content: Text(
                                                  textAlign: TextAlign.center,
                                                  "ادخل مواعيد الحجز",
                                                  style: TextStyles
                                                      .poppins18w500(),
                                                ),
                                              ));
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReserveScreen(
                                            chaletId:
                                                widget.chaletId.toString(),
                                            stayType: chalet
                                                    .prices?[_selectedValue]
                                                    .stayType
                                                    .toString() ??
                                                "",
                                            startDate: value.first
                                                .toString()
                                                .substring(0, 10),
                                            endDate: value.last
                                                .toString()
                                                .substring(0, 10),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
