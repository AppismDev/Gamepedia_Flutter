

import 'package:gamepedia/Models/ApiModels/artwork_model.dart';
import 'package:gamepedia/Models/ApiModels/cover_model.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/screenshot_model.dart';
import 'package:gamepedia/Models/ApiModels/token_info.dart';

abstract class IApiService{

  //Get Token
  Future<TokenInfo?> getTokenInfo();


  // Games Route
  Future<List<GameModel>?> getBestOfAllTime({int? page});

  // Cover Route
  Future<List<CoverModel>?> getCover(String idString);

  // Screenshots Route
  Future<List<ScreenshotsModel>?> getScreenShots(String idString);

  // Artworks Route
  Future<List<ArtworkModel>?> getArtWorks(String idString);

}