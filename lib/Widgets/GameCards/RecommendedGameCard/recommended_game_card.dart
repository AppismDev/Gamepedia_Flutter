import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/DetailsPage/details_page.dart';
import 'package:gamepedia/Widgets/GameCards/RecommendedGameCard/recommended_game_card_viewmodel.dart';
import 'package:shimmer/shimmer.dart';

class RecommendedGameCard extends StatefulWidget {
  RecommendedGameCard({Key? key, required this.gameModel, this.width, this.height}) : super(key: key);

  GameModel gameModel;
  double? width;
  double? height;

  @override
  State<RecommendedGameCard> createState() => _RecommendedGameCardState();
}

class _RecommendedGameCardState extends State<RecommendedGameCard> {
  RecommendedGameCardViewModel _viewModel = RecommendedGameCardViewModel();
  AppConstants _appConstants = AppConstants.instance;

  @override
  void initState() {
    super.initState();
    _viewModel.init(widget.gameModel);
    _viewModel.getScreenShoot();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) => GameDetailsPage(gameModel: widget.gameModel));
        Navigator.of(context).push(route);
      },
      child: Align(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          height: widget.height ?? 200,
          width: widget.width ?? 400,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Stack(
                children: [
                  Observer(builder: (_) {
                    if(_viewModel.loadingImage){
                      return Positioned.fill(
                        child: Shimmer.fromColors(
                          child: Container(
                            width: context.screenWidth,
                            height: 200,
                            color: Colors.transparent,
                          ),
                          baseColor: Colors.grey.shade800,
                          highlightColor: Colors.grey.shade200,
                        ),
                      );
                    }else {
                      if(_viewModel.gameCoverModel != null){
                        return Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                                "${_appConstants.getImageUrl(
                                    _viewModel.gameCoverModel!.imageId!, ImageSize.SCREENSHOT_HUGE)}",
                              fit: BoxFit.fill,

                            ),
                          ),
                        );
                      }else{
                        return Positioned.fill(child: Container(color: Colors.grey,));
                      }
                    }
                  }),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "${widget.gameModel.name}",
                      style:
                          context.theme.textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
