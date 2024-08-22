import 'package:chalet_spot/features/owner/add_chalet/presentation/pages/add_chalet_screen.dart';
import 'package:chalet_spot/features/owner/chalet_details/presentation/pages/chalet_details_screen.dart';
import 'package:chalet_spot/features/owner/home/presentation/pages/owner_home.dart';
import 'package:chalet_spot/features/auth/data/models/reg_response_model.dart';
import 'package:chalet_spot/features/auth/presentation/pages/confirmation_code.dart';
import 'package:chalet_spot/features/auth/presentation/pages/forget_password.dart';
import 'package:chalet_spot/features/auth/presentation/pages/reset_password.dart';
import 'package:chalet_spot/features/auth/presentation/pages/sign_up.dart';
import 'package:chalet_spot/features/auth/presentation/pages/start_screen.dart';
import 'package:chalet_spot/features/edit_profile/presentation/pages/edit_profile.dart';
import 'package:chalet_spot/features/home/presentation/pages/home_layout.dart';
import 'package:chalet_spot/features/owner/home/presentation/pages/owner_single_chalet.dart';
import 'package:chalet_spot/features/owner/home/presentation/pages/reservation_single_screen.dart';
import 'package:flutter/material.dart';

import '../../core/utils/components.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/onboard/page/onboard_screen.dart';
import '../../features/page_details/presentation/pages/page_details.dart';

class Routes {
  static const String onboard = '/';
  static const String start = "start";
  static const String login = "login";
  static const String admin = 'admin';
  static const String forgetPassword = "forgetPassword";
  static const String confirmationCode = "confirmationCode";
  static const String resetPassword = "resetPassword";

  static const String signUp = "signUp";
  static const String home = 'home';
  static const String editProfile = 'editProfile';

  static const String pageDetails = 'pageDetails';
  static const String reserve = 'reserve';

  ///--- Admin ---///

  static const String ownerHome = 'ownerHome';
  static const String ownerSingleChalet = 'ownerSingleChalet';
  static const String addChalet = 'addChalet';
  static const String chaletDetail = 'chaletDetail';
  static const String reservationSingleScreen = 'reservationSingleScreen';
}

class AppRoutes {
  static Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.onboard:
        return MaterialPageRoute(builder: (context) => const OnBoardScreen());

      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.start:
        return MaterialPageRoute(
          builder: (context) => const StartScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeLayout(),
        );

      case Routes.pageDetails:
        String chaletId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => PageDetailsScreen(chaletId: chaletId),
        );

      case Routes.editProfile:
        UserModel user = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (context) => EditProfile(user: user),
        );

      case Routes.signUp:
        Map<String?, String?>? map =
            routeSettings.arguments as Map<String?, String?>;
        return MaterialPageRoute(
          builder: (context) => SignUp(
            firebaseUid: map['firebaseUid'],
            name: map['name'],
            phone: map['phone'],
            email: map['email'],
          ),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgetPassword(),
        );

      case Routes.confirmationCode:
        return MaterialPageRoute(
          builder: (context) => const ConfirmationCode(),
        );

      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => const ResetPassword(),
        );

      ///--- Admin ---///

      case Routes.ownerHome:
        return MaterialPageRoute(
          builder: (context) => const OwnerHome(),
        );
      case Routes.ownerSingleChalet:
        String chaletId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => OwnerSingleChalet(
            chaletId: chaletId,
          ),
        );

      case Routes.addChalet:
        return MaterialPageRoute(
          builder: (context) => const AddChaletScreen(),
        );

      case Routes.chaletDetail:
        String chaletId = routeSettings.arguments as String;

        return MaterialPageRoute(
          builder: (context) => ChaletDetailsScreen(chaletId: chaletId),
        );
      case Routes.reservationSingleScreen:
        String reservationId = routeSettings.arguments as String;

        return MaterialPageRoute(
          builder: (context) =>
              ReservationSingleScreen(reservationId: reservationId),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => unDefineRoute(),
        );
    }
  }
}
