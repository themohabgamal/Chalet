import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/components.dart';
import 'package:chalet_spot/features/home/data/data_sources/search_data_sources.dart';
import 'package:chalet_spot/features/home/presentation/manager/search/search_cubit.dart';
import 'package:chalet_spot/features/home/presentation/manager/search/search_state.dart';
import 'package:chalet_spot/features/home/presentation/widgets/house_card.dart';
import 'package:chalet_spot/features/home/presentation/widgets/sort_button.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/text_styles.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Text(
          "Search".tr(),
          style: TextStyles.appBarTitle(),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            SearchCubit(SearchRemoteDto(DioConsumer(dio: Dio())))
              ..getAllChalets(),
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {},
          builder: (context, state) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SortButton(
                          title: "Sort".tr(),
                          iconName: AppIcons.sort,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SortButton(
                          title: "Type of stay".tr(),
                          iconName: AppIcons.arrowDown,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SortButton(
                          title: "Price".tr(),
                          iconName: AppIcons.arrowDown,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SortButton(
                          title: "Amenities".tr(),
                          iconName: AppIcons.arrowDown,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20.sp,
                              ),
                            ),
                            color: AppColors.lightGreen,
                          ),
                          child: Column(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  iconStyleData: IconStyleData(
                                    icon: SvgPicture.asset(AppIcons.arrowDown),
                                  ),
                                  isExpanded: true,
                                  hint: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Select Location'.tr(),
                                        style: TextStyles.poppins16w500(),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImages.locationIcon,
                                            color: AppColors.black,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            SearchCubit.get(context)
                                                    .selectedValue ??
                                                'الكل'.tr(),
                                            style: TextStyles.poppins14(
                                              weight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  items: SearchCubit.get(context)
                                      .cities
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyles.poppins14(
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: SearchCubit.get(context).selectedValue,
                                  onChanged: (value) {
                                    SearchCubit.get(context).selectValue(value);
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    height: 65.h,
                                    width: double.infinity,
                                  ),
                                  // dropdownStyleData: const DropdownStyleData(
                                  // ),
                                  menuItemStyleData: MenuItemStyleData(
                                    height: 50.h,
                                  ),
                                  dropdownSearchData: DropdownSearchData(
                                    searchController: SearchCubit.get(context)
                                        .textEditingController,
                                    searchInnerWidgetHeight: 50,
                                    searchInnerWidget: Container(
                                      height: 60.h,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextField(
                                        onChanged: (value) {
                                          SearchCubit.get(context)
                                              .getSearchProduct(value);
                                        },
                                        expands: true,
                                        maxLines: null,
                                        controller: SearchCubit.get(context)
                                            .textEditingController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText:
                                              'Search for an chalets...'.tr(),
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return item.value
                                          .toString()
                                          .contains(searchValue);
                                    },
                                  ),
                                  onMenuStateChange: (isOpen) {
                                    if (!isOpen) {
                                      SearchCubit.get(context)
                                          .textEditingController
                                          .clear();
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w,
                                    right: 10.w,
                                    bottom: 10.h,
                                    top: 5.h),
                                child: TextField(
                                  controller: SearchCubit.get(context)
                                      .searchTextEditingController,
                                  onChanged: (value) {
                                    SearchCubit.get(context)
                                        .getSearchProduct(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0.w),
                                      child: SvgPicture.asset(
                                        AppIcons.search,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          25.sp,
                                        ),
                                      ),
                                    ),
                                    hintText: "Search for Chalets".tr(),
                                    hintStyle: TextStyles.poppins12w500(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BlocBuilder<SearchCubit, SearchState>(
                            builder: (context, state) {
                          if (state is SearchGetAllChaletsSuccess) {
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => HouseCard(
                                  chaletModel:
                                      SearchCubit.get(context).chalets[index]),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.h,
                              ),
                              itemCount:
                                  SearchCubit.get(context).chalets.length,
                            );
                          } else if (state is GetFilterChaletsSuccess) {
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => HouseCard(
                                  chaletModel: SearchCubit.get(context)
                                      .filteredChalets[index]),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.h,
                              ),
                              itemCount: SearchCubit.get(context)
                                  .filteredChalets
                                  .length,
                            );
                          } else if (state is NotFoundFilterChalets) {
                            return Text("Not Found".tr());
                          } else {
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  const ShimmerHouseCard(),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.h,
                              ),
                              itemCount: 4,
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
