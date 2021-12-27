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
import 'package:gamepedia/Views/SearchPage/View/search_page.dart';
import 'package:gamepedia/Views/SettingsPage/settings_view.dart';
import 'package:gamepedia/Widgets/GameCards/GameCard/game_card.dart';
import 'package:gamepedia/Widgets/GameCards/RecommendedGameCard/recommended_game_card.dart';
import 'package:gamepedia/Widgets/GenreLiteCard/genre_lite_card.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:gamepedia/Widgets/Search/View/game_search_delegate.dart';
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
    _viewModel.getAllThemes();
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
      actions: [
        IconButton(
          onPressed: () {
            // showSearch(
            //   context: context,
            //   delegate: CustomSearchDelegate(),
            // );
            MaterialPageRoute route = MaterialPageRoute(builder: (context) => SearchPage());
            Navigator.of(context).push(route);
          },
          icon: Icon(Icons.search),
        ),
      ],
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        List<Future> futures = [
          _viewModel.getBestOfAllYearGames(),
          _viewModel.getBestOfLastMonths(),
          _viewModel.getBestOfLastYear(),
          _viewModel.getAllGenres(),
          _viewModel.getAllThemes()
        ];

        await Future.wait(futures);
      },
      strokeWidth: 3,
      displacement: 80,
      color: context.lightThemeData.primaryColor,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Recommended Games
            Padding(
              padding: context.paddingOnlyTopLow,
              child: Observer(
                builder: (_) {
                  if (_viewModel.loadingBestOfAllYearGames) {
                    return buildRecommendedCardShimmer(context);
                  }
                  return Container(
                    width: context.screenWidth,
                    height: context.dynamicHeight(0.3),
                    child: ListView.builder(
                        cacheExtent: context.screenWidth * 4,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _viewModel.bestOfAllYearGames.length,
                        itemBuilder: (context, index) {
                          if (_viewModel.bestOfAllYearGames[index] != null) {
                            return RecommendedGameCard(
                              gameModel: _viewModel.bestOfAllYearGames[index]!,
                              width: context.dynamicWidth(0.925),
                              height: context.dynamicHeight(0.245),
                            );
                          } else {
                            return buildRecommendedCardShimmer(context);
                          }
                        }),
                  );
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
                      builder: (_) {
                        if (_viewModel.loadingAllGenres) {
                          return buildGenresShimmer();
                        } else {
                          return ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: _viewModel.allGenres.length + 2,
                              separatorBuilder: (c, i) => SizedBox(width: context.veryLowValue),
                              itemBuilder: (context, index) {
                                if (index == 0 || index == _viewModel.allGenres.length + 1) {
                                  return SizedBox(
                                    width: context.lowValue,
                                  );
                                } else {
                                  return Align(
                                    child: GenreLiteCard(
                                      genreLiteModel: _viewModel.allGenres[index - 1]!,
                                    ),
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
                    height: context.dynamicHeight(0.3),
                    child: Observer(
                      builder: (_) {
                        if (_viewModel.loadingBestOfLastMonths) {
                          return buildGameCardShimmer();
                        }
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
                                return GameCard(
                                  gameModel: _viewModel.bestOfLastMonths[index - 1]!,
                                );
                              } else {
                                return SizedBox();
                              }
                            });
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
                    height: context.dynamicHeight(0.3),
                    child: Observer(
                      builder: (_) {
                        if (_viewModel.loadingBestOfLastYear) {
                          return buildGameCardShimmer();
                        }
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
                    height: context.dynamicHeight(0.3),
                    child: Observer(
                      builder: (_) {
                        if (_viewModel.loadingBestOfAllYearGames) {
                          return buildGameCardShimmer();
                        }
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
                                return Align(child: GameCard(gameModel: _viewModel.bestOfAllYearGames[index - 1]!));
                              } else {
                                return SizedBox();
                              }
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.mediumValue)
          ],
        ),
      ),
    );
  }

  ListView buildGameCardShimmer() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        cacheExtent: context.screenWidth * 5,
        itemCount: 6,
        separatorBuilder: (context, index) {
          return SizedBox(width: context.lowValue);
        },
        itemBuilder: (context, index) {
          if (index == 0 || index == 5) {
            return SizedBox(
              width: context.lowValue,
            );
          } else {
            return Shimmer.fromColors(
              baseColor:
                  context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
              highlightColor:
                  context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
              child: Container(
                width: 144,
                height: 160,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              ),
            );
          }
        });
  }

  ListView buildGenresShimmer() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (c, i) => SizedBox(width: context.veryLowValue),
        itemBuilder: (context, index) {
          if (index == 0 || index == 5) {
            return SizedBox(
              width: context.lowValue,
            );
          } else {
            return Shimmer.fromColors(
              baseColor:
                  context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
              highlightColor:
                  context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
              child: Align(
                child: Container(
                  height: 44,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: context.theme.primaryColor.withAlpha(160),
                      border: Border.all(color: context.theme.primaryColor, width: 3)),
                ),
              ),
            );
          }
        });
  }

  Widget buildRecommendedCardShimmer(BuildContext context) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          width: context.dynamicWidth(0.925),
          height: context.dynamicHeight(0.245),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
          ),
          child: Shimmer.fromColors(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
            ),
            baseColor:
                context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
            highlightColor:
                context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
