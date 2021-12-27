import 'package:async/async.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/search_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:gamepedia/Widgets/Debouncer/debouncer.dart';
import 'package:mobx/mobx.dart';

part 'game_search_delegate_viewmodel.g.dart';

class GameSearchDelegateViewModel = _GameSearchDelegateViewModelBase with _$GameSearchDelegateViewModel;

abstract class _GameSearchDelegateViewModelBase with Store {
  ApiService _apiService = ApiService.instance;
  ObservableList<GameModel?> searchedGames = ObservableList();
  late CancelableOperation cancelableOperation;

  final _debouncer = Debouncer(milliseconds: 1000);

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


  void searchGames(String query) async {
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
