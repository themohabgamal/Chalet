import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/routes.dart';
import 'main_cubit/main_cubit.dart';
import 'main_cubit/main_state.dart';

class MyApp extends StatelessWidget {
  final String route;

  const MyApp({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(418, 905),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider<MainCubit>(
        create: (context) => MainCubit(),
        child: BlocConsumer<MainCubit, MainState>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                initialRoute: route,
                onGenerateRoute: (settings) => AppRoutes.onGenerate(settings),
               //home: const AdminHome(),
              );
            }),
      ),
    );
  }
}
