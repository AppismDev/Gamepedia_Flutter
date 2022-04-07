import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:mobx/mobx.dart';

part 'favorites_page_viewmodel.g.dart';

class FavoritesPageViewModel = _FavoritesPageViewModelBase with _$FavoritesPageViewModel;

abstract class _FavoritesPageViewModelBase with Store {

  ApiService _apiService = ApiService.instance;

  @observable
  bool _isLoading = false;

  @action
  void setIsLoading(bool value) => _isLoading = value;

  @computed
  bool get isLoading => _isLoading;

  @observable
  ObservableList<GameModel>? favoriteGames = ObservableList();


  void getFavoriteGames(List<String> ids){
    _isLoading = true;
    _apiService.getGamesWithID(ids: ids).then((games){
      if(games != null){
        favoriteGames?.addAll(games);
        _isLoading = false;
      }
    });
  }

}
