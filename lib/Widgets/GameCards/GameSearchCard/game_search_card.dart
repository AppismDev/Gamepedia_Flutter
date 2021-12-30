import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/search_model.dart';
import 'package:gamepedia/Views/DetailsPage/View/details_page.dart';
import 'package:gamepedia/Widgets/Bounce/bounce.dart';
import 'package:gamepedia/Widgets/Bounce/bounce_without_hover.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';


class GameSearchCard extends StatelessWidget {
  GameModel gameModel;

  GameSearchCard({Key? key, required this.gameModel}) : super(key: key);

  AppConstants _appConstants = AppConstants.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: BounceWithoutHover(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => GameDetailsPage(gameModel: gameModel));
          Navigator.of(context).push(route);
        },
        duration: Duration(milliseconds: 100),
        child: Container(
          color: Colors.transparent,
          height: context.dynamicHeight(0.21),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.lowValue,
              horizontal: context.veryLowValue
            ),
            child: Row(
              children: [
                // Cover Image
                if(gameModel.cover != null)
                  Container(
                  width: 100,
                  margin: context.paddingAllVeryLow,
                  child: CachedNetworkImage(
                    imageUrl: "${_appConstants.getImageUrl(gameModel.cover!.imageId!, ImageSize.COVER_BIG)}",
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                    placeholder: (c, url) {
                      return Center(child: GamepediaLogo());
                    },
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )
                else
                  Container(
                    width: 100,
                    child: Center(child: GamepediaLogo()),
                  ),

                SizedBox(width: context.mediumValue),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: context.paddingAllVeryLow,
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "${gameModel.name}",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      if (gameModel.genres != null) ...[
                        Padding(
                          padding: context.paddingOnlyTopLow,
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              addAllGenres(gameModel.genres!),
                              style: context.textTheme.subtitle2!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ] else ...[
                        Padding(
                          padding: context.paddingOnlyTopLow,
                          child: Text("-", style: context.textTheme.subtitle2!),
                        )
                      ],
                      buildScoreStartsWidget(context, gameModel)
                    ],
                  ),
                )

              ],
            )
          ),
        ),
      ),
    );
  }

  Widget buildScoreStartsWidget(BuildContext context, GameModel searchModel) {
    return SizedBox(
      height: context.highValue,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: context.paddingOnlyRightLow,
              child: Icon(FontAwesome5Solid.star,
                  size: 20,
                  color: searchModel.rating == null
                      ? Colors.grey.shade400
                      : index >= (searchModel.rating! / 20).roundToDouble()
                      ? Colors.grey.shade700
                      : Colors.orange),
            );
          }),
    );
  }

  String addAllGenres(List<GameModelGenres?> list) {
    String genres = "";
    if (list.isEmpty) return "";

    for (int i = 0; i < list.length; i++) {
      if (list[i] != null) {
        if (list[i]!.name != null) {
          if (i == list.length - 1) {
            genres += "${list[i]!.name}";
          } else {
            genres += "${list[i]!.name}, ";
          }
        }
      }
    }

    return genres;
  }
}
