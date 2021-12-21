import 'package:gamepedia/Models/ApiModels/cover_model.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:mobx/mobx.dart';
part 'game_card_viewmodel.g.dart';

class GameCardViewModel = _GameCardViewModelBase with _$GameCardViewModel;

abstract class _GameCardViewModelBase with Store{

  ApiService _apiService = ApiService.instance;

  late GameModel _gameModel;


  void init(GameModel gameModel) {
    _gameModel = gameModel;
  }



}