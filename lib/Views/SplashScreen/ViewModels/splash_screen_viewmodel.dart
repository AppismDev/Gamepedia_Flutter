import 'dart:convert';
import 'dart:ffi';

import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Core/Init/Cache/locale_manager.dart';
import 'package:gamepedia/Models/ApiModels/token_info.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:mobx/mobx.dart';
part 'splash_screen_viewmodel.g.dart';

class SplashScreenViewModel = _SplashScreenViewModelBase with _$SplashScreenViewModel;

abstract class _SplashScreenViewModelBase with Store{

  ApiService _apiService = ApiService.instance;
  LocaleManager _localeManager = LocaleManager.instance;



  Future<String?> checkAccessToken() async{
    TokenInfo? tokenInfo;
    String? accessToken;

    
    bool isHaveToken = _localeManager.containsKey(PreferencesKeys.TOKEN_INFO);

    if(isHaveToken){
      String tokenInfoString = _localeManager.getStringValue(PreferencesKeys.TOKEN_INFO);
      Map<String,dynamic> tokenJson = jsonDecode(tokenInfoString);
      tokenInfo = TokenInfo.fromJson(tokenJson);

      int expTimeMilSec = tokenInfo.lastUpdateTimestamp! + tokenInfo.expiresIn!;
      int nowMilSec = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      int dif = expTimeMilSec-nowMilSec;


      // If the difference is 1 day
      if(dif > 86400){
        TokenInfo? tokenInfo = await _apiService.getTokenInfo();
        if(tokenInfo == null) return null;
        String tokenInfoString = jsonEncode(tokenInfo);
        await _localeManager.setStringValue(PreferencesKeys.TOKEN_INFO, tokenInfoString);
        accessToken = tokenInfo.accessToken;
      }else{
        accessToken = tokenInfo.accessToken;
      }

    }else{
      TokenInfo? tokenInfo = await _apiService.getTokenInfo();
      if(tokenInfo == null) return null;
      String tokenInfoString = jsonEncode(tokenInfo);
      await _localeManager.setStringValue(PreferencesKeys.TOKEN_INFO, tokenInfoString);
      accessToken = tokenInfo.accessToken;
    }

    return accessToken;
  }

}