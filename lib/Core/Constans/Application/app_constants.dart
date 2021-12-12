import 'package:flutter_dotenv/flutter_dotenv.dart';


class AppConstants {
  static final AppConstants _instance = AppConstants._init();
  static AppConstants get instance => _instance;
  AppConstants._init();


  // API URLs
  String get API_BASE_URL => dotenv.env['API_BASE_URL']!;

  String get GAMES_ENDPOINT => API_BASE_URL + "/games";
  String get COVER_ENDPOINT => API_BASE_URL + "/cover";

  String getBestOfAllTimeUrl(int page) => GAMES_ENDPOINT + "/bestOfAllTime?page=$page";
  String getCoverUrl(String idString) => COVER_ENDPOINT + "/cover/$idString";

}
