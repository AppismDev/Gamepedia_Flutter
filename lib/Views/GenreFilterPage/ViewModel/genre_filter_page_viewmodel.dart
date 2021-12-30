import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/genre_lite_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:gamepedia/Services/ApiService/i_api_service.dart';
import 'package:mobx/mobx.dart';

part 'genre_filter_page_viewmodel.g.dart';

class GenreFilterPageViewModel = _GenreFilterPageViewModelBase with _$GenreFilterPageViewModel;

abstract class _GenreFilterPageViewModelBase with Store {
  IApiService _apiService = ApiService.instance;

  @observable
  bool _isLoading = false;

  @observable
  ObservableList<GameModel?> genreFilteredGames = ObservableList();

  @computed
  bool get isLoading => _isLoading;

  @action
  void setIsLoading(bool value) => _isLoading = value;

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
      List<GameModel>? genreFilteredGamesResponse = await _apiService.getGenreFilteredGames(list.join(","));
      if (genreFilteredGamesResponse != null) {
        genreFilteredGames.addAll(genreFilteredGamesResponse);
      }

      _isLoading = false;
    }
  }
}
