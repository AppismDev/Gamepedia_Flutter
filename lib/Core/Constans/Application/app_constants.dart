import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';


class AppConstants {
  static final AppConstants _instance = AppConstants._init();
  static AppConstants get instance => _instance;
  AppConstants._init();

//ICONLAR DÜZENLENECEK
  String get LANG_ASSET_PATH => 'assets/language';
  String get ICON_ASSET_PATH => 'assets/icons';
  String get YOUTUBE_VIDEO_URL => "https://www.youtube.com/watch?v=";
  String get YOUTUBE_VIDEO_THUMBNAIL_URL => "https://img.youtube.com/vi";

  // Asset Paths
  String _englishIconPath = "/english.png";
  String _turkeyIconPath = "/turkey.png";
  String _twitchIconPath = "/twitch-icon.jpg";

  // API URLs
  String get API_BASE_URL => dotenv.env['API_BASE_URL']!;
  String get API_LOCAL_URL => dotenv.env['API_LOCAL_URL']!;
  String get IMAGE_UPLOADS_URL => "https://images.igdb.com/igdb/image/upload";


  //Deep Link URLs
  String _baseTwitchGameLink = "twitch://game/";
  String _playStoreAppLink = "http://play.google.com/store/apps/details?id=";
  String _twitchAndroidPackageName = "tv.twitch.android.app";

  //Redirect Link URLs
  String get _twitchGameWEBURL => "https://www.twitch.tv/directory/game";

  String get GAMES_ENDPOINT => API_BASE_URL + "/games";
  String get COVER_ENDPOINT => API_BASE_URL + "/cover";
  String get SCREENSHOTS_ENDPOINT => API_BASE_URL + "/screenshots";
  String get ARTWORKS_ENDPOINT => API_BASE_URL + "/artworks";
  String get GENRES_ENDPOINT => API_BASE_URL + "/genres";
  String get THEMES_ENDPOINT => API_BASE_URL + "/themes";
  String get baseTwitchLink => "twitch://open";


  String get englishIcon => ICON_ASSET_PATH + _englishIconPath;
  String get turkeyIcon => ICON_ASSET_PATH + _turkeyIconPath;
  String get twitchIcon => ICON_ASSET_PATH + _twitchIconPath;
  String get getTwitchPlayStoreDeepLink => _playStoreAppLink + _twitchAndroidPackageName;


  String getBestOfAllTimeEndpoint(int page) => GAMES_ENDPOINT + "/bestOfAllTime?page=$page";
  String getBestOfLastMonthsEndpoint(int page) => GAMES_ENDPOINT + "/bestOfLastMonths?page=$page";
  String getBestOfLastYearEndpoint(int page) => GAMES_ENDPOINT + "/bestOfLastYear?page=$page";
  String getDiscoverEndpoint(int page) => GAMES_ENDPOINT + "/discover?page=$page";
  String getGenreFilterUrl(String genres, int page) => GAMES_ENDPOINT + "/genres?genres=${genres}&page=$page";
  String getGamesWithIDUrl(int page, List<String> ids) => GAMES_ENDPOINT + "/multiDetails?page=$page&ids=${ids.join(',')}";


  String getCoverUrl(String idString) => COVER_ENDPOINT + "/$idString";
  String getScreenshotsUrl(String idString) => SCREENSHOTS_ENDPOINT + "/$idString";
  String getThemesEndPoint() => THEMES_ENDPOINT + "/all";
  String getArtworksUrl(String idString) => ARTWORKS_ENDPOINT + "/$idString";
  String getImageUrl(String hash,ImageSize size) => IMAGE_UPLOADS_URL + "/t_${size.name.toLowerCase()}/${hash}.jpg";
  String getYoutubeVideoUrl(String videoID) => YOUTUBE_VIDEO_URL + "${videoID}";
  String getYoutubeVideoThumbnailUrl(String videoID) => YOUTUBE_VIDEO_THUMBNAIL_URL + "/${videoID}/hqdefault.jpg";
  String getTwitchGameLink(String gameName) => _baseTwitchGameLink + "/${gameName}";
  String getTwitchGameWEBURL(String name) => _twitchGameWEBURL + "/${Uri.encodeComponent(name)}";
  String getSearchUrl(String search) => GAMES_ENDPOINT + "/search?game=$search";

}
