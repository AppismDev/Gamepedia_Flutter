import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/DetailsPage/View/details_page.dart';
import 'package:gamepedia/Widgets/Bounce/bounce_without_hover.dart';
import 'package:gamepedia/Widgets/GameCards/GameCard/game_card_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';

class GameCard extends StatefulWidget {
  GameCard({Key? key, required this.gameModel}) : super(key: key);

  late GameModel gameModel;

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {

  GameCardViewModel _viewModel = GameCardViewModel();
  AppConstants _appConstants = AppConstants.instance;

  @override
  void initState() {
    super.initState();
    _viewModel.init(widget.gameModel);
  }

  @override
  Widget build(BuildContext context) {
    return BounceWithoutHover(
      onPressed: (){
        MaterialPageRoute route = MaterialPageRoute(builder: (context)=>GameDetailsPage(gameModel: widget.gameModel));
        Navigator.of(context).push(route);
      },
      duration: Duration(milliseconds: 100),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  width: 144,
                  height: 160,
                  imageUrl: "${_appConstants.getImageUrl(widget.gameModel.cover!.imageId!, ImageSize.COVER_BIG)}",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: new Container(
                            decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  progressIndicatorBuilder: (context,string,downloadProgress){
                    return Container(
                        width: 120,
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        )
                    );
                  },
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Positioned(
                  right: 0,
                  bottom:10,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            AntDesign.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${widget.gameModel.totalRating?.toInt()} / 100",
                            style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: context.otherTheme.textTheme.bodyText1!.color
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: context.otherTheme.cardColor.withOpacity(0.9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 2),
              child: Container(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    "${widget.gameModel.name}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
