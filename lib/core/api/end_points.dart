class EndPoints {
  ///--- Auth ---///
  static const String login = '/auth/login';
  static const String reg = '/auth/reg';

  ///--- User ---///
  static const String profile = '/user/profile';
  static const String changePassword = '/user/change-password';
  static const String changeInfo = '/user/change-info';
  static const String reservations = '/user/reservations';
  static const String reservedDates = '/user/reserved-dates';
  static const String reserveChalet = '/user/reserve-chalet';
  static const String code = '/user/check-discount';

  ///--- Chalet ---///

  static const String chalet = '/user/all-chalets';
  static const String banner = '/guest/app-banner';

  // static const String chalet = '/user/all-chalets';

  static const String singleChalet = '/user/single-chalet/';

  static const String addToFav = '/user/toggle-favorite';

  //static const String singleChalet = '/user/single-chalet';

  ///--- Admin ---///

  static const String deleteChalet = '/owner/chalet/delete';
  static const String addChalet = '/owner/chalet/new';

  ///--- Reservation ---///
}
