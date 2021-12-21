import 'dart:ui';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Core/Init/Language/locale_keys.g.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:gamepedia/Views/HomePage/ViewModel/home_page_viewmodel.dart';
import 'package:gamepedia/Views/SettingsPage/settings_view.dart';
import 'package:gamepedia/Widgets/GameCards/GameCard/game_card.dart';
import 'package:gamepedia/Widgets/GameCards/RecommendedGameCard/recommended_game_card.dart';
import 'package:gamepedia/Widgets/GenreLiteCard/genre_lite_card.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePageView extends StatefulWidget {
  HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  HomePageViewModel _viewModel = HomePageViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.getBestOfAllYearGames();
    _viewModel.getBestOfLastMonths();
    _viewModel.getBestOfLastYear();
    _viewModel.getAllGenres();
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
              "Ayarlar",
            ),
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) => SettingsView());
              Navigator.of(context).push(route);
            },
          ),
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
                if (_viewModel.bestOfAllYearGames.isNotEmpty) {
                  return Container(
                    width: context.screenWidth,
                    height: 200,
                    child: ListView.builder(
                        cacheExtent: context.screenWidth * 4,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _viewModel.bestOfAllYearGames.length,
                        itemBuilder: (context, index) {
                          if (_viewModel.bestOfAllYearGames[index] != null) {
                            return RecommendedGameCard(
                              gameModel: _viewModel.bestOfAllYearGames[index]!,
                            );
                          } else {
                            return buildRecommendedCardShimmer(context);
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
          Padding(
            padding: context.paddingOnlyTopHigh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: context.paddingHorizontalMedium,
                  child: Text(
                    "Türler",
                    style: context.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  width: context.screenWidth,
                  height: 80,
                  child: Observer(
                    builder:(_) {
                      if(_viewModel.allGenres.isEmpty){
                        return Container(
                          width: context.screenWidth,
                          height: 40,
                          color: Colors.grey,
                        );
                      }else {
                        return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _viewModel.allGenres.length + 2,
                            separatorBuilder: (c,i)=>SizedBox(width: context.veryLowValue),
                            itemBuilder: (context, index) {
                              if (index == 0 || index == _viewModel.allGenres.length + 1) {
                                return SizedBox(
                                  width: context.lowValue,
                                );
                              } else {
                                return Align(
                                  child: GenreLiteCard(genreLiteModel: _viewModel.allGenres[index - 1]!,),
                                );
                              }
                            });
                      }
                    },
                  ),
                ),
              ],
            ),
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
                  height: 200,
                  child: Observer(
                    builder: (_) {
                      if (_viewModel.bestOfLastMonths.isNotEmpty) {
                        return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            cacheExtent: context.screenWidth * 5,
                            itemCount: _viewModel.bestOfLastMonths.length + 2,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: context.lowValue);
                            },
                            itemBuilder: (context, index) {
                              if (index == 0 || index == _viewModel.bestOfLastMonths.length + 1) {
                                return SizedBox(
                                  width: context.lowValue,
                                );
                              }

                              if (_viewModel.bestOfLastMonths[index - 1] != null) {
                                return Align(
                                  child: GameCard(
                                    gameModel: _viewModel.bestOfLastMonths[index - 1]!,
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            });
                      } else {
                        return buildGameCardShimmer(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          //Best Of Last Year Games
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
                  height: 200,
                  child: Observer(
                    builder: (_) {
                      if (_viewModel.bestOfLastYear.isNotEmpty) {
                        return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            cacheExtent: context.screenWidth * 5,
                            itemCount: _viewModel.bestOfLastYear.length + 2,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: context.lowValue);
                            },
                            itemBuilder: (context, index) {
                              if (index == 0 || index == _viewModel.bestOfLastYear.length + 1) {
                                return SizedBox(
                                  width: context.lowValue,
                                );
                              }

                              if (_viewModel.bestOfLastYear[index - 1] != null) {
                                return Align(child: GameCard(gameModel: _viewModel.bestOfLastYear[index - 1]!));
                              } else {
                                return SizedBox();
                              }
                            });
                      } else {
                        return buildGameCardShimmer(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          //Best Of All Year Games
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
                  height: 200,
                  child: Observer(
                    builder: (_) {
                      if (_viewModel.bestOfAllYearGames.isNotEmpty) {
                        return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            cacheExtent: context.screenWidth * 5,
                            itemCount: _viewModel.bestOfAllYearGames.length + 2,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: context.lowValue);
                            },
                            itemBuilder: (context, index) {
                              if (index == 0 || index == _viewModel.bestOfAllYearGames.length + 1) {
                                return SizedBox(
                                  width: context.lowValue,
                                );
                              }

                              if (_viewModel.bestOfAllYearGames[index - 1] != null) {
                                return Align(
                                    child: GameCard(gameModel: _viewModel.bestOfAllYearGames[index - 1]!));
                              } else {
                                return SizedBox();
                              }
                            });
                      } else {
                        return buildGameCardShimmer(context);
                      }
                    },
                  ),
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
        color: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
      ),
      child: Shimmer.fromColors(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
        ),
        baseColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
        highlightColor:
            context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
      ),
    );
  }

  Widget buildGameCardShimmer(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
      ),
      child: Shimmer.fromColors(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
        ),
        baseColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
        highlightColor:
            context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
      ),
    );
  }
}
