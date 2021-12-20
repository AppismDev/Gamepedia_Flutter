import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/DetailsPage/View/details_page.dart';
import 'package:gamepedia/Widgets/GameCards/RecommendedGameCard/recommended_game_card_viewmodel.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class RecommendedGameCard extends StatefulWidget {
  RecommendedGameCard({Key? key, required this.gameModel, this.width = 400, this.height = 200, this.radius = 12})
      : super(key: key);

  GameModel gameModel;
  double width;
  double height;
  double radius;

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
    _viewModel.getCover();
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
          height: widget.height,
          width: widget.width,
          child: Padding(
            padding: EdgeInsets.all(widget.radius),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              elevation: 2,
              child: Stack(
                children: [
                  Observer(builder: (_) {
                    if (_viewModel.loadingImage) {
                      return Positioned.fill(
                        child: buildShimmer(context),
                      );
                    } else {
                      if (_viewModel.gameCoverModel != null) {
                        return CachedNetworkImage(
                          width: widget.width,
                          height: widget.height,
                          imageUrl:
                              "${_appConstants.getImageUrl(_viewModel.gameCoverModel!.imageId!, ImageSize.SCREENSHOT_HUGE)}",
                          imageBuilder: (context, imageProvider) => Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(widget.radius),
                              child: new Container(
                                decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(widget.radius),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (c, url) {
                            return Center(child: GamepediaLogo(size: 22));
                          },
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        );
                      } else {
                        return Positioned.fill(
                          child: buildShimmer(context),
                        );
                      }
                    }
                  }),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: context.paddingAllVeryLow,
                      child: Container(
                        width: widget.width,
                        child: Padding(
                          padding: context.paddingAllLow,
                          child: Text(
                            "${widget.gameModel.name}",
                            style: GoogleFonts.fredokaOne(
                              fontWeight: FontWeight.w700,
                              fontSize: context.textTheme.headline6!.fontSize,
                              color: Colors.grey.shade100
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(widget.radius)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
      ),
    );
  }

  Shimmer buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(widget.radius), color: Colors.grey),
      ),
      baseColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
      highlightColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
    );
  }
}
