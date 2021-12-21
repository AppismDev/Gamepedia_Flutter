import 'package:gamepedia/Models/ApiModels/cover_model.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/screenshot_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:mobx/mobx.dart';

part 'details_page.viewmodel.g.dart';

class DetailsPageViewModel = _DetailsPageViewModelBase with _$DetailsPageViewModel;

abstract class _DetailsPageViewModelBase with Store {
  ApiService _apiService = ApiService.instance;

  late GameModel _gameModel;

  void init(GameModel gameModel) {
    _gameModel = gameModel;
  }

}
