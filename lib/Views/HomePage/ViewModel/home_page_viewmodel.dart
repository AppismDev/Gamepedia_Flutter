import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/genre_lite_model.dart';
import 'package:gamepedia/Models/ApiModels/theme_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:mobx/mobx.dart';

part 'home_page_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {
  ApiService _apiService = ApiService.instance;



  // **************** Best Of All Year Games **************** //

  @observable
  ObservableList<GameModel?> bestOfAllYearGames = ObservableList();

  @observable
  bool _loadingBestOfAllYearGames = true;

  @computed
  bool get loadingBestOfAllYearGames => _loadingBestOfAllYearGames;

  @action
  Future<void> getBestOfAllYearGames() async {
    bestOfAllYearGames.clear();
    _loadingBestOfAllYearGames = true;
    List<GameModel?>? games;
    games = await _apiService.getBestOfAllTime();
    if (games == null) return null;
    bestOfAllYearGames.addAll(games);
    _loadingBestOfAllYearGames = false;
  }

  // **************** Best Of Last Months **************** //

  @observable
  ObservableList<GameModel?> bestOfLastMonths = ObservableList();

  @observable
  bool _loadingBestOfLastMonths = true;

  @computed
  bool get loadingBestOfLastMonths => _loadingBestOfLastMonths;

  @action
  Future<void> getBestOfLastMonths() async {
    bestOfLastMonths.clear();

    _loadingBestOfLastMonths = true;
    List<GameModel?>? games;
    games = await _apiService.getBestOfLastMonths();
    if (games == null) return null;
    bestOfLastMonths.addAll(games);
    _loadingBestOfLastMonths = false;
  }

  // **************** Best Of Last Year **************** //

  @observable
  ObservableList<GameModel?> bestOfLastYear = ObservableList();

  @observable
  ObservableList<ThemeModel?> selectedThemeModels = ObservableList();

  @observable
  ObservableList<GenreLiteModel?> selectedGenreModels = ObservableList();


  @observable
  bool _loadingBestOfLastYear = true;

  @computed
  bool get loadingBestOfLastYear => _loadingBestOfLastYear;

  @action
  Future<void> getBestOfLastYear() async {
    bestOfLastYear.clear();

    _loadingBestOfLastYear = true;
    List<GameModel?>? games;
    games = await _apiService.getBestOfLastYear();
    if (games == null) return null;
    bestOfLastYear.addAll(games);
    _loadingBestOfLastYear = false;
  }

  // **************** All Genres **************** //

  @observable
  ObservableList<GenreLiteModel?> allGenres = ObservableList();

  @observable
  bool _loadingAllGenres = true;

  @computed
  bool get loadingAllGenres => _loadingAllGenres;

  @action
  Future<void> getAllGenres() async {
    allGenres.clear();
    _loadingAllGenres = true;
    List<GenreLiteModel?>? genres;
    genres = await _apiService.getAllGenres();
    if (genres == null) return null;
    allGenres.addAll(genres);
    _loadingAllGenres = false;
  }

// **************** All Themes **************** //

  @observable
  ObservableList<ThemeModel?> allThemes = ObservableList();

  @observable
  bool _loadingAllThemes = true;

  @computed
  bool get loadingAllThemes => _loadingAllThemes;

  @action
  Future<void> getAllThemes() async {
    allThemes.clear();
    _loadingAllThemes = true;
    List<ThemeModel?>? themeModels;
    themeModels = await _apiService.getAllThemes();
    if (themeModels == null) return null;
    allThemes.addAll(themeModels);
    _loadingAllThemes = false;
  }


// **************** ******** **************** //

}
