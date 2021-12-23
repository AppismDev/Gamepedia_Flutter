import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Core/Extensions/string_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/DetailsPage/ViewModel/details_page.viewmodel.dart';
import 'package:gamepedia/Views/VideoPage/View/video_page.dart';
import 'package:gamepedia/Widgets/Clipper/arc_clipper.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    _viewModel.init(widget.gameModel);
  }

  @override
  void dispose() {
    super.dispose();
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
                        placeholder: (context, url) {
                          return mainImagePlaceholder(context);
                        },
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
                                image: imageProvider, alignment: Alignment.topCenter, fit: BoxFit.fitHeight),
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
            padding: EdgeInsets.only(
                right: context.dynamicWidth(0.1), left: context.dynamicWidth(0.1), top: context.lowValue),
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
                      DateTime.fromMillisecondsSinceEpoch(gameModel.firstReleaseDate! * 1000).year.toString(),
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
                      "Rating",
                      style: context.textTheme.subtitle2,
                    ),
                    Text(
                      "${gameModel.rating!.toInt()} / 100",
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
            child: Observer(
              builder: (context) {
                if (_viewModel.isSeeMoreOpen) {
                  return GestureDetector(
                    onTap: () => _viewModel.setIsSeeMoreOpen(!_viewModel.isSeeMoreOpen),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "${gameModel.storyline ?? gameModel.summary} "),
                          WidgetSpan(
                            child: InkWell(
                              child: Text(
                                "Daralt", // TODO Locazilation Yapılacak
                                style: context.textTheme.bodyText1!.copyWith(
                                    color: Colors.blue[800]
                                ),
                              ),
                              onTap: () {
                                _viewModel.setIsSeeMoreOpen(false);
                              },
                            ),
                          ),
                          // TextSpan(
                          //   text: 'bold',
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () => _viewModel.setIsSeeMoreOpen(!_viewModel.isSeeMoreOpen),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "${gameModel.storyline?.getLimitedText ?? gameModel.summary?.getLimitedText}... "),
                          WidgetSpan(
                            child: Text(
                              "Daha Fazla Gör", // TODO: Localization Yapılacak
                              style: context.textTheme.bodyText1!.copyWith(color: Colors.blue[800]),
                            ),
                          ),
                          // TextSpan(
                          //   text: 'bold',
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            // child: Text(
            //   "${gameModel.storyline?.substring(0, 300) ?? gameModel.summary?.substring(0, 50)}",
            //   style: context.textTheme.subtitle1,
            //   textAlign: TextAlign.center,
            // ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                // padding: const EdgeInsets.all(8.0),
                padding: EdgeInsets.only(left: context.mediumValue, bottom: context.lowValue, top: context.lowValue),
              ),
              if (gameModel.platforms != null)
                Container(
                  height: 50,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: context.lowValue,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: gameModel.platforms!.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: _appConstants.getImageUrl(
                                gameModel.platforms![index]!.platformLogo!.imageId!, ImageSize.THUMB),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                  ),
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      SizedBox(
                        width: context.lowValue,
                      ),
                    ],
                  ),
                )
              else
                SizedBox()
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: context.mediumValue, bottom: context.lowValue, top: context.mediumValue),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Screenshots",
                style: context.textTheme.headline6,
              ),
            ),
          ),
          if (gameModel.screenshots != null)
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
                        buildScreenshotCard(gameModel.screenshots![index]?.imageId),
                      ],
                    );
                  } else if (index == gameModel.screenshots!.length - 1) {
                    return Row(
                      children: [
                        buildScreenshotCard(gameModel.screenshots![index]?.imageId),
                        SizedBox(width: context.mediumValue),
                      ],
                    );
                  } else {
                    return buildScreenshotCard(gameModel.screenshots![index]?.imageId);
                  }
                },
              ),
            )
          else
            // TODO : (AHMET) Ekran Görüntüsü olmayan oyunlar için arayüz düzenlemesi
            Text("Ekran Görüntüsü Yok"),
          Padding(
            padding: EdgeInsets.only(left: context.mediumValue, bottom: context.lowValue, top: context.mediumValue),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Videos",
                style: context.textTheme.headline6,
              ),
            ),
          ),
          if (gameModel.videos != null)
            Container(
              height: context.dynamicHeight(0.25),
              child: ListView.builder(
                primary: true,
                physics: BouncingScrollPhysics(),
                cacheExtent: context.screenWidth * 4,
                scrollDirection: Axis.horizontal,
                itemCount: gameModel.videos!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      index == 0 ? SizedBox(width: context.mediumValue) : SizedBox(),
                      buildVideoCard(gameModel.videos![index]!.videoId!),
                      index == gameModel.videos!.length - 1 ? SizedBox(width: context.mediumValue) : SizedBox(),
                    ],
                  );
                },
              ),
            )
          else
            // TODO : (AHMET) Ekran Görüntüsü olmayan oyunlar için arayüz düzenlemesi
            Text("Ekran Görüntüsü Yok"),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  ClipPath mainImagePlaceholder(BuildContext context) {
    return ClipPath(
      clipper: ProfileClipper(),
      clipBehavior: Clip.antiAlias,
      child: Container(
        child: ClipRRect(
          child: Shimmer.fromColors(
            baseColor:
                context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
            highlightColor:
                context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
            child: Container(
              width: context.screenWidth,
              height: (context.safeScreenHeight / 2.1) - context.appBarHeight,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVideoCard(String videoID) {
      return Hero(
        tag: videoID,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false, // set to false
                pageBuilder: (_, __, ___) => VideoPage(
                  videoID: videoID,
                ),
              ),
            );
          },
          child: SizedBox(
            child: Padding(
              padding: context.paddingAllLow,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      _appConstants.getYoutubeVideoThumbnailUrl(videoID),
                      width: context.dynamicWidth(0.6),
                      fit: BoxFit.cover,
                    ),
                    Icon(
                        Fontisto.youtube_play,
                        color: Colors.red,
                        size: 40,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  Widget buildScreenshotCard(String? imageID) {
    if (imageID != null) {
      return Container(
        margin: context.paddingAllVeryLow,
        width: context.dynamicWidth(0.5),
        height: context.dynamicHeight(0.18),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: _appConstants.getImageUrl(
              imageID,
              ImageSize.SCREENSHOT_MED,
            ),
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return SizedBox();
    }
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
