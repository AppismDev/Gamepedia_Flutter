import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/genre_lite_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:mobx/mobx.dart';

part 'home_page_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {


  ApiService _apiService = ApiService.instance;



  @observable
  ObservableList<GameModel?> bestOfAllYearGames = ObservableList();

  @observable
  ObservableList<GameModel?> bestOfLastMonths = ObservableList();

  @observable
  ObservableList<GameModel?> bestOfLastYear = ObservableList();

  @observable
  ObservableList<GenreLiteModel?> allGenres = ObservableList();

  @action
  Future<void> getBestOfAllYearGames() async{
    List<GameModel?>? games;
    games = await _apiService.getBestOfAllTime();
    if (games == null) return null;
    bestOfAllYearGames.addAll(games);
  }


  @action
  Future<void> getBestOfLastMonths() async{
    List<GameModel?>? games;
    games = await _apiService.getBestOfLastMonths();
    if (games == null) return null;
    bestOfLastMonths.addAll(games);
  }


  @action
  Future<void> getBestOfLastYear() async{
    List<GameModel?>? games;
    games = await _apiService.getBestOfLastYear();
    if (games == null) return null;
    bestOfLastYear.addAll(games);
  }


  @action
  Future<void> getAllGenres() async{
    List<GenreLiteModel?>? genres;
    genres = await _apiService.getAllGenres();
    if (genres == null) return null;
    allGenres.addAll(genres);
  }


}
