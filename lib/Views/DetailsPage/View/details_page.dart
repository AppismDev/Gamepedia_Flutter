import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Core/Extensions/string_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/DetailsPage/ViewModel/details_page.viewmodel.dart';
import 'package:gamepedia/Views/ImageViewerPage/View/image_viewer_page.dart';
import 'package:gamepedia/Views/VideoPage/View/video_page.dart';
import 'package:gamepedia/Widgets/Clipper/arc_clipper.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:gamepedia/Widgets/Painter/details_page_image_shadow_painter.dart';
import 'package:gamepedia/Widgets/PlatformChip/platform_chip.dart';
import 'package:gamepedia/Widgets/TwitchDialog/twitch_dialog.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // ************************* WIDGETS **************************

  Widget buildSizedBox(BuildContext context, GameModel gameModel) {
    if (gameModel == null) {
      //TODO Bulunamadı tarzı bir sayfa
      return SizedBox();
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildCoverImage(context, gameModel),
          buildGameNameText(context, gameModel),
          buildGenresText(context, gameModel),
          buildScoreStartsWidget(context, gameModel),
          buildInfoBannerWidget(context, gameModel),
          buildStoryLine(context, gameModel),
          buildPlatforms(context, gameModel),
          // ScreenShots Text
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
            buildScreenShotsList(context, gameModel)
          else
            // TODO : (AHMET) Ekran Görüntüsü olmayan oyunlar için arayüz düzenlemesi
            Text("Ekran Görüntüsü Yok"),

          // Videos Text
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
            buildVideosList(context, gameModel)
          else
            // TODO : (AHMET) Ekran Görüntüsü olmayan oyunlar için arayüz düzenlemesi
            Text("Video Yok"),

          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  Container buildCoverImage(BuildContext context, GameModel gameModel) {
    return Container(
      height: (context.safeScreenHeight / 2.1) - context.appBarHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            painter: DetailsPageImageShadowPainter(),
            child: ClipPath(
              clipper: ProfileClipper(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: context.theme.scaffoldBackgroundColor,
                width: context.screenWidth,
                height: (context.safeScreenHeight / 2.1) - context.appBarHeight,
                child: Align(
                  child: widget.gameModel.cover == null || widget.gameModel.cover!.imageId == null
                      ? Container(
                          child: GamepediaLogo(
                          size: 30,
                        ))
                      : CachedNetworkImage(
                          placeholder: (context, url) {
                            return mainImagePlaceholder(context);
                          },
                          imageUrl:
                              "${_appConstants.getImageUrl(widget.gameModel.cover!.imageId!, ImageSize.SCREENSHOT_HUGE)}",
                          imageBuilder: (context, imageProvider) => Container(
                            child: ClipRRect(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.0),
                                ),
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
          ),
          Positioned(
            top: (context.safeScreenHeight / 2.70) - context.appBarHeight,
            child: buildTwitchButton(context, gameModel),
          )
        ],
      ),
    );
  }

  Container buildVideosList(BuildContext context, GameModel gameModel) {
    return Container(
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
    );
  }

  Container buildScreenShotsList(BuildContext context, GameModel gameModel) {
    return Container(
      height: context.dynamicHeight(0.24),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        cacheExtent: context.screenWidth * 4,
        scrollDirection: Axis.horizontal,
        itemCount: gameModel.screenshots!.length + 2,
        separatorBuilder: (c, i) => SizedBox(width: context.lowValue),
        itemBuilder: (context, index) {
          if (index == 0 || index == gameModel.screenshots!.length + 1) {
            return SizedBox(width: context.lowValue);
          } else {
            return buildScreenshotCard(gameModel.screenshots![index - 1]?.imageId);
          }
        },
      ),
    );
  }

  Widget buildPlatforms(BuildContext context, GameModel gameModel) {
    if (gameModel.platforms != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              // padding: const EdgeInsets.all(8.0),
              padding: EdgeInsets.only(left: context.mediumValue, top: context.mediumValue),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Platforms",
                  style: context.textTheme.headline6,
                ),
              )),
          Container(
            height: 100,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: context.mediumValue,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: gameModel.platforms!.length,
                  separatorBuilder: (c, i) => SizedBox(width: context.lowValue),
                  itemBuilder: (context, index) {
                    if (gameModel.platforms![index] == null) {
                      return SizedBox();
                    } else {
                      return PlatformChip(
                        platform: gameModel.platforms![index]!,
                        colorIndex: index,
                      );
                    }
                  },
                ),
                SizedBox(
                  width: context.lowValue,
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Padding buildStoryLine(BuildContext context, GameModel gameModel) {
    if (gameModel.storyline == null && gameModel.summary == null) {
      return Padding(
        padding: context.paddingHorizontalHigh,
        child: Text("Bu oyun hakkında bir detay bulunamadı."),
      );
    } else {
      return Padding(
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
                            style: context.textTheme.bodyText1!.copyWith(color: context.lightThemeData.primaryColor),
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
                      TextSpan(text: "${gameModel.storyline?.getLimitedText ?? gameModel.summary?.getLimitedText}... "),
                      WidgetSpan(
                        child: Text(
                          "Daha Fazla Gör", // TODO: Localization Yapılacak
                          style: context.textTheme.bodyText1!.copyWith(color: context.lightThemeData.primaryColor),
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
      );
    }
  }

  Row buildInfoBannerWidget(BuildContext context, GameModel gameModel) {
    return Row(
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
                gameModel.firstReleaseDate == null
                    ? "-"
                    : DateTime.fromMillisecondsSinceEpoch(gameModel.firstReleaseDate! * 1000).year.toString(),
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
                "${gameModel.rating == null ? "-" : gameModel.rating!.toInt()} / 100",
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
    );
  }

  Padding buildScoreStartsWidget(BuildContext context, GameModel gameModel) {
    return Padding(
      padding: context.paddingOnlyTopLow,
      child: SizedBox(
        height: context.highValue,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: context.paddingOnlyLeftLow,
                child: Icon(
                  FontAwesome5Solid.star,
                  color: gameModel.rating == null
                      ? context.theme.iconTheme.color
                      : index >= (gameModel.rating! / 20).roundToDouble()
                          ? context.theme.iconTheme.color
                          : context.theme.primaryIconTheme.color,
                ),
              );
            }),
      ),
    );
  }

  Widget buildGenresText(BuildContext context, GameModel gameModel) {
    if (gameModel.genres != null) {
      return Padding(
          padding: context.paddingOnlyTopLow,
          child: Wrap(
            children: List.generate(gameModel.genres!.length,
                (i) => gameModel.genres![i] == null ? SizedBox() : Text("${gameModel.genres![i]!.name}")),
          ));
    } else {
      return SizedBox();
    }
  }

  Padding buildGameNameText(BuildContext context, GameModel gameModel) {
    return Padding(
      padding:
          EdgeInsets.only(right: context.dynamicWidth(0.1), left: context.dynamicWidth(0.1), top: context.lowValue),
      child: Text(
        "${gameModel.name}",
        textAlign: TextAlign.center,
        style: context.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  ElevatedButton buildTwitchButton(BuildContext context, GameModel gameModel) {
    return ElevatedButton(
      onPressed: () async {
        showDialog(
          context: context,
          barrierColor: Colors.black.withAlpha(210),
          builder: (context) {
            return TwitchDialog(
              onAccept: () async {
                if (await canLaunch(_appConstants.baseTwitchLink)) {
                  if (gameModel.name != null) {
                    await launch(_appConstants.getTwitchGameLink(gameModel.name!));
                  }
                } else {
                  //TODO i18n ;) yapılacak ve tasarım değiştirilecek

                  String twitchWebURL = _appConstants.getTwitchGameWEBURL(gameModel.name!);

                  if (await canLaunch(twitchWebURL)) {
                    await launch(twitchWebURL);
                  }
                }
              },
            );
          },
        );
      },
      child: Center(
        child: Icon(
          Fontisto.twitch,
          color: Colors.white,
          size: 26,
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          padding: MaterialStateProperty.all(context.paddingAllMedium),
          backgroundColor: MaterialStateProperty.all(Color(0xff6441a5)),
          elevation: MaterialStateProperty.all(10)),
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
        onTap: () {
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
      return Align(
        child: GestureDetector(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ImageViewerPage(
                url: _appConstants.getImageUrl(
                  imageID,
                  ImageSize.SCREENSHOT_HUGE,
                ),
              ),
            );
            Navigator.of(context).push(route);
          },
          child: Hero(
            tag: _appConstants.getImageUrl(
              imageID,
              ImageSize.SCREENSHOT_MED,
            ),
            child: Container(
              margin: context.paddingAllVeryLow,
              width: context.dynamicWidth(0.6),
              height: context.dynamicHeight(0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: _appConstants.getImageUrl(
                    imageID,
                    ImageSize.SCREENSHOT_MED,
                  ),
                  placeholder: (context, url) {
                    return Center(
                      child: GamepediaLogo(size: 30),
                    );
                  },
                  fit: BoxFit.fill,
                ),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), boxShadow: [
                BoxShadow(
                  color: context.currentAppThemeEnum == ThemeEnums.LIGHT_MODE
                      ? Colors.grey.shade700
                      : context.darkThemeData.primaryColorDark,
                  blurRadius: 20,
                  offset: Offset(2, 2),
                )
              ]),
            ),
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
