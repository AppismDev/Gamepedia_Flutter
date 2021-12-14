import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:mobx/mobx.dart';

part 'home_page_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {


  ApiService _apiService = ApiService.instance;



  @observable
  ObservableList<GameModel?> bestOfAllYearGames = ObservableList();

  @action
  Future<void> getBestOfAllYearGames() async{
    List<GameModel?>? games;
    games = await _apiService.getBestOfAllTime();
    if (games == null) return null;
    bestOfAllYearGames.addAll(games);
  }




}
