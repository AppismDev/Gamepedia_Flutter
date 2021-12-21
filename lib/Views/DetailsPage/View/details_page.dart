import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/DetailsPage/ViewModel/details_page.viewmodel.dart';
import 'package:gamepedia/Widgets/Clipper/arc_clipper.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:shimmer/shimmer.dart';

class GameDetailsPage extends StatefulWidget {
  GameModel gameModel;

  GameDetailsPage({Key? key, required this.gameModel}) : super(key: key);

  @override
  State<GameDetailsPage> createState() => _GameDetailsPageState();
}

//TODO appbar animation add
class _GameDetailsPageState extends State<GameDetailsPage> {
  DetailsPageViewModel _viewModel = DetailsPageViewModel();
  AppConstants _appConstants = AppConstants.instance;

  @override
  void initState() {
    super.initState();
    _viewModel.init(widget.gameModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildSizedBox(context, widget.gameModel),
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
            height: (context.safeScreenHeight / 2.1) - context.appBarHeight,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: ProfileClipper(),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: BoxDecoration(
                      // boxShadow: BoxShadow
                    ),
                    width: context.screenWidth,
                    height: (context.safeScreenHeight / 2.1) - context.appBarHeight,
                    child: Align(
                      child: CachedNetworkImage(
                        imageUrl:
                        "${_appConstants.getImageUrl(widget.gameModel.cover!.imageId!, ImageSize.SCREENSHOT_HUGE)}",
                        imageBuilder: (context, imageProvider) => Container(
                          child: ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                            ),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // bottom: context.screenHeight / 23,
                  top: (context.safeScreenHeight / 2.64) - context.appBarHeight,
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
            padding: EdgeInsets.only(right: context.dynamicWidth(0.1), left: context.dynamicWidth(0.1), top: context.lowValue),
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
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: context.mediumValue, bottom: context.lowValue, top: context.mediumValue),
            child: Text(
              "Screenshots",
              style: context.textTheme.headline6,
            ),
          ),
          if(gameModel.screenshots != null)
            Container(
            height: context.dynamicHeight(0.18),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              cacheExtent: context.screenWidth * 4,
              scrollDirection: Axis.horizontal,
              itemCount: gameModel.screenshots!.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Row(
                    children: [
                      SizedBox(width: context.mediumValue),
                      buildScreenshotCard(index),
                    ],
                  );
                } else if (index == gameModel.screenshots!.length - 1) {
                  return Row(
                    children: [
                      buildScreenshotCard(index),
                      SizedBox(width: context.mediumValue),
                    ],
                  );
                } else {
                  return buildScreenshotCard(index);
                }
              },
            ),
          )
          else
            // TODO : (AHMET) Ekran Görüntüsü olmayan oyunlar için arayüz düzenlemesi
            Text("Ekran Görüntüsü Yok"),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget buildScreenshotCard(int index) {
    return Container(
      margin: context.paddingAllVeryLow,
      width: context.dynamicWidth(0.5),
      height: context.dynamicHeight(0.18),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: _appConstants.getImageUrl(
            widget.gameModel.screenshots![index]!.imageId!,
            ImageSize.SCREENSHOT_MED,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Shimmer buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      child: ClipPath(
        clipper: ProfileClipper(),
        child: Container(
          decoration: BoxDecoration(color: Colors.white
              // boxShadow: BoxShadow
              ),
          width: context.screenWidth,
          height: (context.safeScreenHeight / 2.1) - AppBar().preferredSize.height,
        ),
      ),
      baseColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
      highlightColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      title: GamepediaLogo(
        size: 18,
      ),
    );
  }

  Widget screenshotShimmer() {
    return Shimmer.fromColors(
      child: Container(
        width: context.dynamicWidth(0.5),
        height: context.dynamicHeight(0.18),
        margin: context.paddingAllVeryLow,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      ),
      baseColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
      highlightColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
    );
  }
}
