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
import 'package:gamepedia/Views/FavoritesPage/View/favorites_page.dart';
import 'package:gamepedia/Views/GenreFilterPage/View/genre_filter_page.dart';
import 'package:gamepedia/Views/HomePage/ViewModel/home_page_viewmodel.dart';
import 'package:gamepedia/Views/SearchPage/View/search_page.dart';
import 'package:gamepedia/Views/SettingsPage/settings_view.dart';
import 'package:gamepedia/Widgets/Bounce/bounce_without_hover.dart';
import 'package:gamepedia/Widgets/Chips/GenreChips/genre_chip.dart';
import 'package:gamepedia/Widgets/Chips/ThemeChips/theme_chip.dart';
import 'package:gamepedia/Widgets/GameCards/GameCard/game_card.dart';
import 'package:gamepedia/Widgets/GameCards/RecommendedGameCard/recommended_game_card.dart';
import 'package:gamepedia/Widgets/GenreLiteCard/genre_lite_card.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:gamepedia/Widgets/Search/View/game_search_delegate.dart';
import 'package:gamepedia/Widgets/Shimmers/chip_shimmer.dart';
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
              "Favorilerim",
            ),
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) => FavoritesPage());
              Navigator.of(context).push(route);
            },
          ),
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
        _viewModel.selectedGenreModels.clear();
        _viewModel.selectedThemeModels.clear();
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
            buildRecommendedGamesList(),

            //New Released Popular Games
            buildNewReleasedGamesList(),

            //Best Of Last Year Games
            buildBestOfLastYearGamesList(),

            //Best Of All Year Games
            buildBestOfAllYearGamesList(),

            //Categories Page View
            buildCategoryTabs(),

            SizedBox(height: context.mediumValue)
          ],
        ),
      ),
    );
  }

  Padding buildRecommendedGamesList() {
    return Padding(
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
    );
  }

  Padding buildNewReleasedGamesList() {
    return Padding(
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
    );
  }

  Padding buildBestOfLastYearGamesList() {
    return Padding(
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
    );
  }

  Padding buildBestOfAllYearGamesList() {
    return Padding(
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
    );
  }

  Padding buildCategoryTabs() {
    return Padding(
      padding: context.paddingAllMedium,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  tabs: [
                    Tab(
                        child: Text(
                      "Türler",
                      style: context.textTheme.subtitle2,
                    )),
                    Tab(
                        child: Text(
                      "Temalar",
                      style: context.textTheme.subtitle2,
                    )),
                  ],
                ),

                Container(
                  height: context.dynamicHeight(0.5),
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        primary: true,
                        child: Padding(
                          padding: context.paddingOnlyTopHigh,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: context.paddingHorizontalMedium,
                                    child: Text(
                                      "Türler",
                                      style: context.textTheme.subtitle2!
                                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: context.paddingHorizontalMedium,
                                    child: InkWell(
                                        child: Text(
                                          "Filtrele",
                                          style: context.textTheme.subtitle2
                                              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
                                        ),
                                        onTap: () {
                                          MaterialPageRoute route = MaterialPageRoute(builder: (context)=> GenreFilterPage(genres: _viewModel.selectedGenreModels.toList()));
                                          Navigator.of(context).push(route);

                                        },
                                  ))
                                ],
                              ),
                              Observer(
                                builder: (_) {
                                  if (_viewModel.loadingAllGenres) {
                                    return Padding(
                                      padding: context.paddingAllLow,
                                      child: ChipShimmer(),
                                    );
                                  } else {
                                    return Padding(
                                      padding: context.paddingAllLow,
                                      child: Wrap(
                                        spacing: 6,
                                        children: List.generate(_viewModel.allGenres.length,
                                            // _viewModel.allGenres.length ~/ 2,
                                            (index) {
                                          return _viewModel.allGenres[index] == null
                                              ? SizedBox()
                                              : GenreChip(
                                              isSelected: _viewModel.selectedGenreModels
                                                  .contains(_viewModel.allGenres[index]),
                                                  genreLiteModel: _viewModel.allGenres[index]!,
                                                  selectedColor: Colors.primaries[index % Colors.primaries.length].shade700,
                                                  onPressed: () {
                                                    bool haveModel = _viewModel.selectedGenreModels
                                                        .contains(_viewModel.allGenres[index]);
                                                    if (!haveModel) {
                                                      _viewModel.selectedGenreModels.add(_viewModel.allGenres[index]);
                                                    } else {
                                                      _viewModel.selectedGenreModels
                                                          .remove(_viewModel.allGenres[index]);
                                                    }
                                                  });
                                        }),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        primary: true,
                        child: Padding(
                          padding: context.paddingOnlyTopHigh,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: context.paddingHorizontalMedium,
                                    child: Text(
                                      "Temalar",
                                      style: context.textTheme.subtitle2!
                                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                      padding: context.paddingHorizontalMedium,
                                      child: InkWell(
                                        child: Text(
                                          "Filtrele",
                                          style: context.textTheme.subtitle2
                                              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
                                        ),
                                        onTap: () {
                                          _viewModel.selectedThemeModels.forEach((element) {
                                            print(element?.id);
                                          });
                                        },
                                      ))
                                ],
                              ),
                              Observer(
                                builder: (_) {
                                  if (_viewModel.loadingAllThemes) {
                                    return Padding(
                                      padding: context.paddingAllLow,
                                      child: ChipShimmer(),
                                    );
                                  } else {
                                    return Padding(
                                      padding: context.paddingAllLow,
                                      child: Wrap(
                                        spacing: 6,
                                        children: List.generate(_viewModel.allThemes.length,
                                            //   _viewModel.allThemes.length ~/ 2,
                                            (index) {
                                          return _viewModel.allThemes[index] == null
                                              ? SizedBox()
                                              : Observer(
                                                  builder: (context) {
                                                    return ThemeChip(
                                                      onPressed: () {
                                                        bool haveModel = _viewModel.selectedThemeModels
                                                            .contains(_viewModel.allThemes[index]);
                                                        if (!haveModel) {
                                                          _viewModel.selectedThemeModels
                                                              .add(_viewModel.allThemes[index]);
                                                        } else {
                                                          _viewModel.selectedThemeModels
                                                              .remove(_viewModel.allThemes[index]);
                                                        }
                                                      },
                                                      isSelected: _viewModel.selectedThemeModels
                                                          .contains(_viewModel.allThemes[index]),
                                                      themeModel: _viewModel.allThemes[index]!,
                                                      selectedColor:
                                                          Colors.primaries[index % Colors.primaries.length].shade700,
                                                    );
                                                  },
                                                );
                                        }),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            return Align(
              child: Shimmer.fromColors(
                baseColor:
                    context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
                highlightColor:
                    context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
                child: Container(
                  width: 144,
                  height: context.dynamicHeight(0.26),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                ),
              ),
            );
          }
        });
  }

  Align buildRecommendedCardShimmer(BuildContext context) {
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
