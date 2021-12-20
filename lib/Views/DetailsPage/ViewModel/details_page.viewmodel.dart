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

  @observable
  bool _loadingImage = true;

  @computed
  bool get loadingImage => _loadingImage;

  @observable
  CoverModel? gameCoverModel;

  @action
  Future<void> getCover() async {
    _loadingImage = true;

    if (_gameModel.id == null) return;

    List<CoverModel> coverList = await _apiService.getCover(_gameModel.cover!.toString()) ?? [];
    if (coverList.isEmpty) return;

    gameCoverModel = coverList.first;

    _loadingImage = false;
  }

  @observable
  // Scree? gameCoverModel;
  ScreenshotsModel? screenshotsModel;

  @observable
  ObservableList<ScreenshotsModel>? screenshotsModels = ObservableList();


  @action
  Future<void> getScreenshot() async {
    String screenshotIds = "";
    _loadingImage = true;


    if (_gameModel.screenshots == null) return;

    for(int i = 0; i < _gameModel.screenshots!.length; i++){
      if(i != _gameModel.screenshots!.length -1) {
        screenshotIds += _gameModel.screenshots![i].toString() + ",";
      }else{
        screenshotIds += _gameModel.screenshots![i].toString();
      }
    }

    List<ScreenshotsModel> screenShotList =
        await _apiService.getScreenShots(screenshotIds) ?? [];
    if (screenShotList.isEmpty) return;

    screenshotsModel = screenShotList.first;
    screenshotsModels!.addAll(screenShotList);
    _loadingImage = false;
  }
}
