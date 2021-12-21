import 'dart:convert';

import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Models/ApiModels/artwork_model.dart';
import 'package:gamepedia/Models/ApiModels/cover_model.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/genre_lite_model.dart';
import 'package:gamepedia/Models/ApiModels/screenshot_model.dart';
import 'package:gamepedia/Models/ApiModels/token_info.dart';
import 'package:gamepedia/Services/ApiService/i_api_service.dart';
import 'package:http/http.dart' as http;

class ApiService extends IApiService {
  
  ApiService._privateConstructor();
  static final ApiService _instance = ApiService._privateConstructor();
  static  ApiService get instance => _instance;


  String? accessToken;
  final AppConstants _appConstants = AppConstants.instance;


  @override
  Future<TokenInfo?> getTokenInfo() async {
    try {
      Uri url = Uri.parse(_appConstants.API_BASE_URL + "/token");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        TokenInfo tokenInfo = TokenInfo.fromJson(body);
        _instance.accessToken = tokenInfo.accessToken;
        return tokenInfo;
      } else {
        print("[HATA] [ApiService] [getTokenInfo] --> " + response.statusCode.toString());
        print(response.body);
        return null;
      }
    } catch (e) {
      print("[HATA] [ApiService] [getTokenInfo] --> " + e.toString());
      return null;
    }
  }

  @override
  Future<List<GameModel>?> getBestOfAllTime({int? page}) async {
    try {
      page ??= 1;
      Uri url = Uri.parse(_appConstants.getBestOfAllTimeUrl(page));

      if (accessToken == null) {
        throw Exception("Token Not be Null");
      }

      Map<String, String> headers = {'Authorization': 'token=' + accessToken!};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<GameModel> games = [];
        List body = jsonDecode(response.body);

        body.forEach((gameElement) {
          games.add(GameModel.fromJson(gameElement));
        });
        games.shuffle();
        return games;
      } else {
        print("[HATA] [ApiService] [getBestOfAllTime] --> " + response.statusCode.toString());
        print(response.body);
        return null;
      }
    } catch (e) {
      print("[HATA] [ApiService] [getBestOfAllTime] --> " + e.toString());
      return null;
    }
  }

  @override
  Future<List<GameModel>?> getBestOfLastMonths({int? page}) async {
    try {
      page ??= 1;
      Uri url = Uri.parse(_appConstants.getBestOfLastMonths(page));

      if (accessToken == null) {
        throw Exception("Token Not be Null");
      }

      Map<String, String> headers = {'Authorization': 'token=' + accessToken!};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<GameModel> games = [];
        List body = jsonDecode(response.body);

        body.forEach((gameElement) {
          games.add(GameModel.fromJson(gameElement));
        });
        games.shuffle();
        return games;
      } else {
        print("[HATA] [ApiService] [getBestOfLastMonths] --> " + response.statusCode.toString());
        print(response.body);
        return null;
      }
    } catch (e) {
      print("[HATA] [ApiService] [getBestOfLastMonths] --> " + e.toString());
      return null;
    }
  }

  @override
  Future<List<GameModel>?> getBestOfLastYear({int? page}) async {
    try {
      page ??= 1;
      Uri url = Uri.parse(_appConstants.getBestOfLastYear(page));

      if (accessToken == null) {
        throw Exception("Token Not be Null");
      }

      Map<String, String> headers = {'Authorization': 'token=' + accessToken!};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<GameModel> games = [];
        List body = jsonDecode(response.body);

        body.forEach((gameElement) {
          games.add(GameModel.fromJson(gameElement));
        });
        games.shuffle();
        return games;
      } else {
        print("[HATA] [ApiService] [getBestOfLastYear] --> " + response.statusCode.toString());
        print(response.body);
        return null;
      }
    } catch (e) {
      print("[HATA] [ApiService] [getBestOfLastYear] --> " + e.toString());
      return null;
    }
  }


  @override
  Future<List<GenreLiteModel>?> getAllGenres() async{
    try {

      Uri url = Uri.parse(_appConstants.GENRES_ENDPOINT+'/allGenres');

      if (accessToken == null) {
        throw Exception("Token Not be Null");
      }

      Map<String, String> headers = {'Authorization': 'token=' + accessToken!};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<GenreLiteModel> genres = [];
        List body = jsonDecode(response.body);
        body.forEach((gameElement) {
          genres.add(GenreLiteModel.fromJson(gameElement));
        });
        return genres;
      } else {
        print("[HATA] [ApiService] [getAllGenres] --> " + response.statusCode.toString());
        print(response.body);
        return null;
      }
    } catch (e) {
      print("[HATA] [ApiService] [getAllGenres] --> " + e.toString());
      return null;
    }
  }



  @override
  Future<List<CoverModel>?> getCover(String idString) async{
    try {
      Uri url = Uri.parse(_appConstants.getCoverUrl(idString));

      if (accessToken == null) {
        throw Exception("Token Not be Null");
      }

      Map<String, String> headers = {'Authorization': 'token=' + accessToken!};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<CoverModel> covers = [];
        List body = jsonDecode(response.body);

        body.forEach((gameElement) {
          covers.add(CoverModel.fromJson(gameElement));
        });
        return covers;
      } else {
        print("[HATA] [ApiService] [getCover] --> " + response.statusCode.toString());
        print(response.body);
        return null;
      }
    } catch (e) {
      print("[HATA] [ApiService] [getCover] --> " + e.toString());
      return null;
    }
  }

  @override
  Future<List<ScreenshotsModel>?> getScreenShots(String idString) async{
    try {
      Uri url = Uri.parse(_appConstants.getScreenshotsUrl(idString));

      if (accessToken == null) {
        throw Exception("Token Not be Null");
      }

      Map<String, String> headers = {'Authorization': 'token=' + accessToken!};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<ScreenshotsModel> screenShots = [];
        List body = jsonDecode(response.body);

        body.forEach((gameElement) {
          screenShots.add(ScreenshotsModel.fromJson(gameElement));
        });
        return screenShots;
      } else {
        print("[HATA] [ApiService] [getScreenShots] --> " + response.statusCode.toString());
        print(response.body);
        return null;
      }
    } catch (e) {
      print("[HATA] [ApiService] [getScreenShots] --> " + e.toString());
      return null;
    }

  }

  @override
  Future<List<ArtworkModel>?> getArtWorks(String idString) async{
    try {
      Uri url = Uri.parse(_appConstants.getArtworksUrl(idString));

      if (accessToken == null) {
        throw Exception("Token Not be Null");
      }

      Map<String, String> headers = {'Authorization': 'token=' + accessToken!};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<ArtworkModel> artWorks = [];
        List body = jsonDecode(response.body);

        body.forEach((gameElement) {
          artWorks.add(ArtworkModel.fromJson(gameElement));
        });
        return artWorks;
      } else {
        print("[HATA] [ApiService] [getArtWorks] --> " + response.statusCode.toString());
        print(response.body);
        return null;
      }
    } catch (e) {
      print("[HATA] [ApiService] [getArtWorks] --> " + e.toString());
      return null;
    }
  }




}
