import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/features/home/presentation/manager/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../core/utils/app_icons.dart';
import '../manager/home/home_cubit.dart';
import '../widgets/stroke_text.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({
    super.key,
  });

  @override
  HomeLayoutState createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: HomeCubit.get(context).bottomScreens[_currentIndex],
          bottomNavigationBar: Card(
            color: Colors.white,
            elevation: 10, // Adjusted elevation
            child: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                // Home
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(AppIcons.home),
                  title: const StrokeText(text: 'Home'),
                  selectedColor: AppColors.lightGrey,
                  activeIcon: SvgPicture.asset(AppIcons.selectedHome),
                ),

                // Search
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(AppIcons.search),
                  title: const StrokeText(text: 'Search'),
                  selectedColor: AppColors.lightGrey,
                  activeIcon: SvgPicture.asset(AppIcons.selectedSearch),
                ),

                // Booking
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(AppIcons.fav),
                  title: const StrokeText(text: 'Booking'),
                  selectedColor: AppColors.lightGrey,
                  activeIcon: SvgPicture.asset(AppIcons.selectedFav),
                ),

                // Profile
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(AppIcons.profile),
                  title: const StrokeText(text: 'Profile'),
                  selectedColor: AppColors.lightGrey,
                  activeIcon: SvgPicture.asset(AppIcons.selectedProfile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
