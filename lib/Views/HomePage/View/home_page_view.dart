import 'dart:ui';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Core/Init/Language/language_manager.dart';
import 'package:gamepedia/Core/Init/Language/locale_keys.g.dart';
import 'package:gamepedia/Providers/Language/language_provider.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:gamepedia/Views/HomePage/ViewModel/home_page_viewmodel.dart';
import 'package:gamepedia/Widgets/GameCards/RecommendedGameCard/recommended_game_card.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePageView extends StatefulWidget {
  HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  HomePageViewModel _homePageViewModel = HomePageViewModel();

  @override
  void initState() {
    super.initState();
    _homePageViewModel.getBestOfAllYearGames();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      drawer: buildDrawer(context),
      floatingActionButton: buildFAB(_themeProvider),
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              "English",
            ),
            onTap: () async {
              await Provider.of<LanguageProvider>(context, listen: false)
                  .setCurrentLocale(LanguageManager.instance.enLocale, context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            onTap: () async {
              await Provider.of<LanguageProvider>(context, listen: false)
                  .setCurrentLocale(LanguageManager.instance.trLocale, context);
              Navigator.pop(context);
            },
            title: Text(
              "Türkçe",
            ),
          )
        ],
      ),
    );
  }

  FloatingActionButton buildFAB(ThemeProvider _themeProvider) {
    return FloatingActionButton(
      onPressed: () {
        _themeProvider.switchTheme();
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: GamepediaLogo(
        size: 18,
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          // Recommended Games
          Padding(
            padding: context.paddingOnlyTopLow,
            child: Observer(
              builder: (_) {
                if (_homePageViewModel.bestOfAllYearGames.length > 0) {
                  return Container(
                    width: context.screenWidth,
                    height: 200,
                    child: ListView.builder(
                        cacheExtent: context.screenWidth * 4,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _homePageViewModel.bestOfAllYearGames.length,
                        itemBuilder: (context, index) {
                          if (index == 0 || index == _homePageViewModel.bestOfAllYearGames.length - 1) {
                            return SizedBox(
                              width: context.lowValue,
                            );
                          } else {
                            if (_homePageViewModel.bestOfAllYearGames[index] != null) {
                              return RecommendedGameCard(
                                gameModel: _homePageViewModel.bestOfAllYearGames[index]!,
                              );
                            } else {
                              return buildRecommendedCardShimmer(context);
                            }
                          }
                        }),
                  );
                } else {
                  return buildRecommendedCardShimmer(context);
                }
              },
            ),
          ),

          // Categories
          Container(
            margin: context.paddingOnlyTopMedium,
            width: context.screenWidth,
            height: 80,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  if (index == 0 || index == 5) {
                    return SizedBox(
                      width: context.mediumValue,
                    );
                  } else {
                    return Align(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                        height: 80,
                        width: 185,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          color: Colors.red,
                          elevation: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "ACTION",
                                style: context.theme.textTheme.headline6!
                                    .copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ),

          //New Released Popular Games
          Padding(
            padding: context.paddingOnlyTopHigh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: context.paddingHorizontalMedium,
                  child: Text(
                    LocaleKeys.homePage_newReleasedPopularGames.tr(),
                    style: context.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  margin: context.paddingOnlyTopLow,
                  width: context.screenWidth,
                  height: 225,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        if (index == 0 || index == 6) {
                          return SizedBox(
                            width: context.mediumValue,
                          );
                        } else {
                          return Align(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 225,
                              width: 170,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    "https://upload.wikimedia.org/wikipedia/tr/thumb/6/67/Avengersendgame.jpg/220px-Avengersendgame.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
          //Best Of Year Games
          Padding(
            padding: context.paddingOnlyTopHigh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: context.paddingHorizontalMedium,
                  child: Text(
                    LocaleKeys.homePage_bestOfYear.tr(),
                    style: context.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  margin: context.paddingOnlyTopLow,
                  width: context.screenWidth,
                  height: 225,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        if (index == 0 || index == 6) {
                          return SizedBox(
                            width: context.mediumValue,
                          );
                        } else {
                          return Align(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 225,
                              width: 170,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    "https://upload.wikimedia.org/wikipedia/tr/thumb/6/67/Avengersendgame.jpg/220px-Avengersendgame.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
          //Best Of Year Games
          Padding(
            padding: context.paddingOnlyTopHigh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: context.paddingHorizontalMedium,
                  child: Text(
                    LocaleKeys.homePage_bestOfAllTime.tr(),
                    style: context.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  margin: context.paddingOnlyTopLow,
                  width: context.screenWidth,
                  height: 225,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        if (index == 0 || index == 6) {
                          return SizedBox(
                            width: context.mediumValue,
                          );
                        } else {
                          return Align(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 225,
                              width: 170,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    "https://upload.wikimedia.org/wikipedia/tr/thumb/6/67/Avengersendgame.jpg/220px-Avengersendgame.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
          SizedBox(height: context.mediumValue)
        ],
      ),
    );
  }

  Widget buildRecommendedCardShimmer(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color : context.currentAppThemeEnum == ThemeEnums.DARK_MODE
              ? Colors.grey.shade900
              : Colors.grey.shade300,
      ),
      child: Shimmer.fromColors(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
        ),
        baseColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE
            ? Colors.grey.shade900
            : Colors.grey.shade300,
        highlightColor:
            context.currentAppThemeEnum == ThemeEnums.DARK_MODE
                ? Colors.grey.shade800
                : Colors.grey.shade200,
      ),
    );
  }
}
