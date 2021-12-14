import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Widgets/Clipper/arc_clipper.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:shimmer/shimmer.dart';

class GameDetailsPage extends StatelessWidget {
  GameModel gameModel;

  GameDetailsPage({Key? key, required this.gameModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: buildSizedBox(context, gameModel),
    );
  }

  Widget buildSizedBox(BuildContext context, GameModel gameModel) {
    if (gameModel == null) {
      //TODO Bulunamadı tarzı bir sayfa
      return SizedBox();
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: context.screenHeight / 2.3,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: ProfileClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        // boxShadow: BoxShadow
                        ),
                    width: context.screenWidth,
                    height: context.safeScreenHeight / 2.3,
                    child: Image.network(
                      "https://www.indiewire.com/wp-content/uploads/2018/10/1533732394498.jpeg",
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Shimmer.fromColors(
                            child: ClipPath(
                              clipper: ProfileClipper(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white
                                    // boxShadow: BoxShadow
                                    ),
                                width: context.screenWidth,
                                height: context.safeScreenHeight / 2.3,
                                child: Image.network(
                                  "https://www.indiewire.com/wp-content/uploads/2018/10/1533732394498.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            baseColor: Colors.grey.shade200,
                            highlightColor: Colors.grey.shade400);
                      },
                    ),
                  ),
                ),
                /*
                * ClipPath(
                    clipper: ProfileClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                          // boxShadow: BoxShadow
                          ),
                      width: context.screenWidth,
                      height: context.safeScreenHeight / 2.3,
                      child: Image.network(
                        "https://www.indiewire.com/wp-content/uploads/2018/10/1533732394498.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )*/
                Positioned(
                  // bottom: context.screenHeight / 23,
                  top: context.safeScreenHeight / 2.98,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      FontAwesome5Solid.play,
                      color: context.theme.primaryColor,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      padding: MaterialStateProperty.all(context.paddingAllMedium),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.dynamicHeight(0.1)),
            child: Text(
              "${gameModel.name}",
              textAlign: TextAlign.center,
              style: context.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: context.paddingOnlyTopLow,
            child: Text(
              "Adventure, Family, Fantasy",
              style: context.textTheme.subtitle2,
            ),
          ),
          Padding(
            padding: context.paddingOnlyTopLow,
            child: SizedBox(
              height: context.highValue,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    //3 yıldız almış bir örnek
                    return Padding(
                      padding: context.paddingOnlyLeftLow,
                      child: Icon(
                        FontAwesome5Solid.star,
                        color: index >= (gameModel.rating! / 20).roundToDouble()
                            ? context.theme.iconTheme.color
                            : context.theme.primaryIconTheme.color,
                      ),
                    );
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.lowValue),
                child: Column(
                  children: [
                    Text(
                      "Year",
                      style: context.textTheme.subtitle2,
                    ),
                    Text(
                      "2018",
                      style: context.textTheme.headline6!.copyWith(fontSize: 19),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: context.paddingHorizontalMedium,
                child: Column(
                  children: [
                    Text(
                      "Country",
                      style: context.textTheme.subtitle2,
                    ),
                    Text(
                      "USA",
                      style: context.textTheme.headline6!.copyWith(fontSize: 19),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: context.paddingHorizontalMedium,
                child: Column(
                  children: [
                    Text(
                      "Lenght",
                      style: context.textTheme.subtitle2,
                    ),
                    Text(
                      "112 min",
                      style: context.textTheme.headline6!.copyWith(fontSize: 19),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: context.paddingHorizontalHigh,
            child: Text(
              "${gameModel.summary}",
              style: context.textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      backgroundColor: Colors.transparent,
      title: GamepediaLogo(
        size: 18,
      ),
    );
  }
}
