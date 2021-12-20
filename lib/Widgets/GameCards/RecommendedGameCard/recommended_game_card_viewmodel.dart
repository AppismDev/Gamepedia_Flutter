import 'package:gamepedia/Models/ApiModels/cover_model.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:mobx/mobx.dart';
part 'recommended_game_card_viewmodel.g.dart';

class RecommendedGameCardViewModel = _RecommendedGameCardViewModelBase with _$RecommendedGameCardViewModel;

abstract class _RecommendedGameCardViewModelBase with Store{

  ApiService _apiService = ApiService.instance;

  late GameModel _gameModel;

  void init(GameModel gameModel){
    _gameModel = gameModel;
  }

  @observable
  bool _loadingImage = true;

  @computed
  bool get loadingImage => _loadingImage;

  @observable
  CoverModel? gameCoverModel;


  @action
  Future<void> getCover() async{
    _loadingImage = true;

    if(_gameModel.id == null) return;

    List<CoverModel> coverList = await _apiService.getCover(_gameModel.cover!.toString()) ?? [];
    if(coverList.isEmpty) return;

    gameCoverModel = coverList.first;

    _loadingImage = false;

  }

}