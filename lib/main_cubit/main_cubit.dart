import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/routes/routes.dart';
import '../core/utils/app_images.dart';
import '../core/utils/cache_helper.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  void toggleLanguage(BuildContext context, String lang) {
    CacheHelper.saveData(key: "lang", value: 'Arabic');

    EasyLocalization.of(context)!.setLocale(
      lang == "English"
          ? const Locale('en')
          : lang == "Arabic"
              ? const Locale('ar')
              : const Locale('en'),
    );
  }

  ///--- onBoard ---///

  List<Map<String, String?>> onboardList = [
    {
      "title": "مرحبًا بك بـ ChaletSpot",
      "description": "أول تطبيق لحجز الشاليهات والمزارع في الأردن",
      "image": AppImages.onboard1,
    },
    {
      "title": "احجز بسهولة واكتشف",
      "description": "أفضل الأسعار بنقرة واحدة",
      "image": AppImages.onboard2,
    },
    {
      "title": "فريقنا سيتواصل معك",
      "description": "لتأكيد حجزك خلال دقائق",
      "image": AppImages.onboard3,
    }
  ];

  onNextButton(BuildContext context) {
    if (counter < onboardList.length - 1) {
      counter++;
      emit(OnBoardChange());
    } else {
      Navigator.pushReplacementNamed(context, Routes.start);
    }
  }
}
