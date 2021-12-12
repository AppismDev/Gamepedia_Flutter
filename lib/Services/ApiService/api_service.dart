import 'dart:convert';

import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Models/ApiModels/cover_model.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/token_info.dart';
import 'package:gamepedia/Services/ApiService/i_api_service.dart';
import 'package:http/http.dart' as http;

class ApiService extends IApiService{

  ApiService._privateConstructor();
  static final ApiService _instance = ApiService._privateConstructor();

  String? accessToken;
  final AppConstants _appConstants = AppConstants.instance;

  factory ApiService({String? accessToken}) {
    if(accessToken != null){
      _instance.accessToken = accessToken;
    }else{
      _instance.getTokenInfo();
    }
    return _instance;
  }


  @override
  Future<TokenInfo?> getTokenInfo() async{
    try {
      Uri url = Uri.parse(_appConstants.API_BASE_URL+"/token");
      http.Response response = await http.get(url);

      if(response.statusCode == 200){
        Map<String,dynamic> body = jsonDecode(response.body);
        TokenInfo tokenInfo = TokenInfo.fromJson(body);
        _instance.accessToken = tokenInfo.accessToken;
        return tokenInfo;
      }else{
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
  Future<List<GameModel?>?> getBestOfAllTime({int? page}) {
    // TODO: implement getBestOfAllTime
    throw UnimplementedError();
  }

  @override
  Future<List<CoverModel?>?> getCover(String idString) {
    // TODO: implement getCover
    throw UnimplementedError();
  }


}