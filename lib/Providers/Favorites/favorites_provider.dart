import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Core/Init/Cache/locale_manager.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';

class FavoritesProvider extends ChangeNotifier {
  LocaleManager _localeManager = LocaleManager.instance;
  ApiService _apiService = ApiService.instance;
  bool isLoading = false;

  //id olanlar
  List<String> favoritesID = [];

  //gamemodeller
  List<GameModel> favoriteGames = [];

  FavoritesProvider() {
    if (!_localeManager.getListValue(PreferencesKeys.FAVORITES).isEmpty) {
      favoritesID.addAll(_localeManager.getListValue(PreferencesKeys.FAVORITES));
    }
  }

  void addFavoriteGame(GameModel gameModel) {
    favoritesID.add(gameModel.id.toString());
    favoriteGames.add(gameModel);
    _localeManager.setListValue(PreferencesKeys.FAVORITES, favoritesID);
    notifyListeners();
  }

  void removeFavoriteGame(String id) {
    favoritesID.remove(id);
    favoriteGames.removeWhere((element) => element.id.toString() == id);
    _localeManager.setListValue(PreferencesKeys.FAVORITES, favoritesID);
    notifyListeners();
  }

  Future<void> getFavoriteGames() async {
    if (favoriteGames.isEmpty && favoritesID.isNotEmpty) {
      isLoading = true;
      await _apiService.getGamesWithID(ids: favoritesID).then((games) {
        if (games != null) {
          favoriteGames.addAll(games);
          isLoading = false;
        }
      });
      notifyListeners();
    }
  }
}
