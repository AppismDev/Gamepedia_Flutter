import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';

import 'package:mobx/mobx.dart';

part 'search_page_viewmodel.g.dart';

class SearchPageViewModel = _SearchPageViewModelBase with _$SearchPageViewModel;

abstract class _SearchPageViewModelBase with Store {
  ApiService _apiService = ApiService.instance;


  @observable
  bool _isShowHistory = false;

  @computed
  bool get isShowHistory => _isShowHistory;

  @action
  void setIsShowHistory(bool value) => _isShowHistory = value;

  @observable
  bool _isShowDiscover = true;

  @computed
  bool get isShowDiscover => _isShowDiscover;

  @observable
  String searchText = "";

  @action
  void setSearchText(String value) => searchText = value;

  @observable
  bool _loadingContent = false;

  @computed
  bool get loadingContent => _loadingContent;

  @observable
  ObservableList<GameModel> searchedGames = ObservableList();

  @observable
  ObservableList<GameModel> discover = ObservableList();

  @action
  Future<void> searchGame() async{
    _loadingContent = true;
    _isShowDiscover = false;

    searchedGames.clear();

    if(searchText.isEmpty){
      _isShowDiscover = true;
      searchedGames.clear();
      _loadingContent = false;
      return;
    }


    List<GameModel>? games = await _apiService.searchGames(searchText);

    if(games != null){
      searchedGames.addAll(games);
    }


    _loadingContent = false;
  }

  @action
  Future<void> getDiscover() async{
    _loadingContent = true;

    List<GameModel>? games = await _apiService.getDiscoverGames();

    if(games != null){
      discover.addAll(games);
    }

    _loadingContent = false;
  }

}
