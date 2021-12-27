import 'package:flutter/material.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';

import 'package:mobx/mobx.dart';

part 'search_page_viewmodel.g.dart';

class SearchPageViewModel = _SearchPageViewModelBase with _$SearchPageViewModel;

abstract class _SearchPageViewModelBase with Store {
  ApiService _apiService = ApiService.instance;
  ObservableList<GameModel?> searchedGames = ObservableList();
  TextEditingController controller = TextEditingController();

  String query = "";

  String oldQuery = "";

  @observable
  bool _isLoading = false;

  @observable
  bool isQueryFinished = true;

  @computed
  bool get isLoading => _isLoading;

  @action
  void setIsLoading(bool value) => _isLoading = value;

  @action
  void clearSearchGames() {
    searchedGames.clear();
  }



  //TODO aramada çıkan hatalara bakılacak
  void searchGames() async {
    isQueryFinished = false;

    if (query.trim().isNotEmpty) {
      if (oldQuery != query.trim()) {
        oldQuery = query.trim();
        setIsLoading(true);
        List<GameModel>? searchedGamesResult = [];
        if (query.trim().isNotEmpty) {
          searchedGamesResult = await _apiService.searchGames(query);
          clearSearchGames();
          if (searchedGamesResult == null) {
            setIsLoading(false);
            return null;
          }
          searchedGames.addAll(searchedGamesResult);
        } else {
          clearSearchGames();
        }
        oldQuery = query;
        setIsLoading(false);
        isQueryFinished = true;
      }
    } else {
      clearSearchGames();
    }
  }
}
