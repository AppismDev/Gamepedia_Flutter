import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';


class AppConstants {
  static final AppConstants _instance = AppConstants._init();
  static AppConstants get instance => _instance;
  AppConstants._init();


  String get LANG_ASSET_PATH => 'assets/language';
  String get ICON_ASSET_PATH => 'assets/icons/';
  String get YOUTUBE_VIDEO_URL => "https://www.youtube.com/watch?v=";
  String get YOUTUBE_VIDEO_THUMBNAIL_URL => "https://img.youtube.com/vi";

  // API URLs
  String get API_BASE_URL => dotenv.env['API_BASE_URL']!;
  String get IMAGE_UPLOADS_URL => "https://images.igdb.com/igdb/image/upload";


  String get GAMES_ENDPOINT => API_BASE_URL + "/games";
  String get COVER_ENDPOINT => API_BASE_URL + "/cover";
  String get SCREENSHOTS_ENDPOINT => API_BASE_URL + "/screenshots";
  String get ARTWORKS_ENDPOINT => API_BASE_URL + "/artworks";
  String get GENRES_ENDPOINT => API_BASE_URL + "/genres";
  String get THEMES_ENDPOINT => API_BASE_URL + "/themes";

  String getBestOfAllTimeUrl(int page) => GAMES_ENDPOINT + "/bestOfAllTime?page=$page";
  String getBestOfLastMonths(int page) => GAMES_ENDPOINT + "/bestOfLastMonths?page=$page";
  String getBestOfLastYear(int page) => GAMES_ENDPOINT + "/bestOfLastYear?page=$page";


  String getCoverUrl(String idString) => COVER_ENDPOINT + "/$idString";
  String getScreenshotsUrl(String idString) => SCREENSHOTS_ENDPOINT + "/$idString";
  String getThemesEndPoint() => THEMES_ENDPOINT + "/all";
  String getArtworksUrl(String idString) => ARTWORKS_ENDPOINT + "/$idString";
  String getImageUrl(String hash,ImageSize size) => IMAGE_UPLOADS_URL + "/t_${size.name.toLowerCase()}/${hash}.jpg";
  String getYoutubeVideoUrl(String videoID) => YOUTUBE_VIDEO_URL + "${videoID}";
  String getYoutubeVideoThumbnailUrl(String videoID) => YOUTUBE_VIDEO_THUMBNAIL_URL + "/${videoID}/hqdefault.jpg";
}
