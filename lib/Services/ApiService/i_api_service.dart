

import 'package:gamepedia/Models/ApiModels/artwork_model.dart';
import 'package:gamepedia/Models/ApiModels/cover_model.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/genre_lite_model.dart';
import 'package:gamepedia/Models/ApiModels/screenshot_model.dart';
import 'package:gamepedia/Models/ApiModels/theme_model.dart';
import 'package:gamepedia/Models/ApiModels/token_info.dart';

abstract class IApiService{

  //Get Token
  Future<TokenInfo?> getTokenInfo();


  // Games Route
  Future<List<GameModel>?> getBestOfAllTime({int? page});
  Future<List<GameModel>?> getBestOfLastMonths({int? page});
  Future<List<GameModel>?> getBestOfLastYear({int? page});
  Future<List<GameModel>?> getGenreFilteredGames(String genres,{int? page});

  Future<List<GameModel>?> searchGames(String searchText);

  // Genres Route
  Future<List<GenreLiteModel>?> getAllGenres();

  // Cover Route
  Future<List<CoverModel>?> getCover(String idString);

  // Screenshots Route
  Future<List<ScreenshotsModel>?> getScreenShots(String idString);

  // Artworks Route
  Future<List<ArtworkModel>?> getArtWorks(String idString);

  //Themes Mode
  Future<List<ThemeModel>?> getAllThemes();

}