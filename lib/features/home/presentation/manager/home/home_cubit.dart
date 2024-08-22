import 'package:chalet_spot/features/home/presentation/pages/bottom_screens/home_tab.dart';
import 'package:chalet_spot/features/home/presentation/pages/bottom_screens/profile.dart';
import 'package:chalet_spot/features/home/presentation/pages/bottom_screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../booking/presentation/pages/fav.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens = [
    const HomeTab(),
    const SearchTab(),
    const BookingTab(),
     const ProfilePage()
  ];
}
