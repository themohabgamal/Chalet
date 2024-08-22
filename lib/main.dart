import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'config/routes/routes.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/observer.dart';
import 'firebase_options.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print('Initializing CacheHelper...');
  await CacheHelper.init();
  print('CacheHelper initialized');

  // Determine the initial route based on the authentication status and role
  String route;
  String? token = CacheHelper.getData('token');
  String? role = CacheHelper.getData('role');
  print(CacheHelper.getData('role'));
  if (token == null) {
    route = Routes.onboard;
  } else {
    route = role == 'CHALET_OWNER' ? Routes.ownerHome : Routes.home;
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: MyApp(route: route),
      //child: DevicePreview(builder: (context) => MyApp(route: route)),
    ),
  );
}
