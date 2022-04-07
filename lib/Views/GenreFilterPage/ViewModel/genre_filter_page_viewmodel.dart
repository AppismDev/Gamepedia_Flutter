import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/genre_lite_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:gamepedia/Services/ApiService/i_api_service.dart';
import 'package:mobx/mobx.dart';

part 'genre_filter_page_viewmodel.g.dart';

class GenreFilterPageViewModel = _GenreFilterPageViewModelBase with _$GenreFilterPageViewModel;

abstract class _GenreFilterPageViewModelBase with Store {
  int paginationPage = 1;

  ApiService _apiService = ApiService.instance;

  @observable
  bool _isLoading = false;

  @observable
  bool _isPaginationLoading = false;

  @observable
  ObservableList<GameModel?> genreFilteredGames = ObservableList();

  @computed
  bool get isLoading => _isLoading;

  @computed
  bool get isPaginationLoading => _isPaginationLoading;

  @action
  void setIsLoading(bool value) => _isLoading = value;

  @action
  void setIsPaginationLoading(bool value) => _isPaginationLoading = value;

  @action
  Future<void> getFilteredGames(List<GenreLiteModel?> genres) async {
    List<int> list = [];
    genres.forEach((element) {
      if (element != null && element.id != null) {
        list.add(element.id!);
      }
    });

    if (list.isNotEmpty) {
      _isLoading = true;
      List<GameModel>? genreFilteredGamesResponse =
          await _apiService.getGenreFilteredGames(list.join(","), page: paginationPage);
      if (genreFilteredGamesResponse != null) {
        genreFilteredGames.addAll(genreFilteredGamesResponse);
        paginationPage++;
        _isPaginationLoading = false;
      }

      _isLoading = false;
    }
  }

  @action
  Future<void> getFilteredGamesPagination(List<GenreLiteModel?> genres) async {
    List<int> list = [];
    genres.forEach((element) {
      if (element != null && element.id != null) {
        list.add(element.id!);
      }
    });

    if (list.isNotEmpty) {
      _isPaginationLoading = true;
      paginationPage++;
      List<GameModel>? genreFilteredGamesResponse =
          await _apiService.getGenreFilteredGames(list.join(","), page: paginationPage);
      if (genreFilteredGamesResponse != null) {
        genreFilteredGames.addAll(genreFilteredGamesResponse);
      }

      _isPaginationLoading = false;
    }
  }
}
