import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/DetailsPage/View/details_page.dart';
import 'package:gamepedia/Widgets/Bounce/bounce_without_hover.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';

class GameFilterCard extends StatelessWidget {
  GameModel gameModel;

  GameFilterCard({Key? key, required this.gameModel}) : super(key: key);

  AppConstants _appConstants = AppConstants.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllVeryLow,
      child: BounceWithoutHover(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => GameDetailsPage(gameModel: gameModel));
          Navigator.of(context).push(route);
        },
        duration: Duration(milliseconds: 100),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 45,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    if (gameModel.cover != null && gameModel.cover!.imageId != null) ...[
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: _appConstants.getImageUrl(gameModel.cover!.imageId!, ImageSize.COVER_BIG),
                          imageBuilder: (context, imageProvider) => ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                            child: Image(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, progress) {
                            return Center(child: CircularProgressIndicator(value: progress.progress,),);
                          },
                        ),
                      ),
                    ] else ...[
                      Center(
                        child: GamepediaLogo(),
                      )
                    ],
                    Padding(
                      padding: context.paddingOnlyBottomLow,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
                          color: Colors.grey.shade800,
                        ),
                        child: Padding(
                          padding: context.paddingAllVeryLow,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: context.paddingOnlyRightVeryLow,
                                child: Icon(
                                  FontAwesome5Solid.star,
                                  color: Colors.orange,
                                  size: 13,
                                ),
                              ),
                              Text(
                                "${gameModel.rating?.toInt()} / 100",
                                style: context.theme.textTheme.caption!.copyWith(color: Colors.grey.shade200),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: context.paddingAllLow,
                  child: Text(
                    "${gameModel.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
