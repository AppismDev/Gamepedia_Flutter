import 'dart:ui';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Core/Init/Language/language_manager.dart';
import 'package:gamepedia/Core/Init/Language/locale_keys.g.dart';
import 'package:gamepedia/Providers/Language/language_provider.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:gamepedia/Views/DetailsPage/details_page.dart';
import 'package:gamepedia/Views/HomePage/ViewModel/home_page_viewmodel.dart';
import 'package:gamepedia/Widgets/GameCard/home_page_game_card.dart';
import 'package:gamepedia/Widgets/ListView/card_listview.dart';

import 'package:provider/provider.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  HomePageViewModel _homePageViewModel = HomePageViewModel();

  @override
  Widget build(BuildContext context) {
    print("Home page rebuilded");
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      drawer: Drawer(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _themeProvider.switchTheme();
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Gamepedia"),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CardListView(
                itemBuilder: (context, index) {
                  if (index == 0 || index == 5) {
                    return SizedBox(
                      width: 12,
                    );
                  } else {
                    return HomePageGameCard(
                      borderRadius: 12,
                      height: 220,
                      width: 400,
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(builder: (context)=> GameDetailsPage());
                        Navigator.of(context).push(route);
                      },
                      child: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "THE NUTCRACKER AND THE FOUR REALMS",
                              style: context.theme.textTheme.headline6!
                                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                itemCount: 5,
                itemHeight: 200),
            SizedBox(
              height: 35,
            ),
            CardListView(
              itemBuilder: (context, index) {
                if (index == 0 || index == 4) {
                  return const SizedBox(
                    width: 12,
                  );
                }
                return HomePageGameCard(
                  borderRadius: 10,
                  width: 165,
                  height: 75,
                  onTap: () async {},
                  child: Container(
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "ACTION",
                        style: context.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 5,
              itemHeight: 75,
            ),
            SizedBox(
              height: 30,
            ),
            //TODO valuelara extension yazılacak
            CardListView(
                itemBuilder: (context, index) {
                  if (index == 0 || index == 4) {
                    return const SizedBox(
                      width: 12,
                    );
                  } else {
                    return HomePageGameCard(
                      height: 200,
                      onTap: () {},
                      child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/tr/thumb/6/67/Avengersendgame.jpg/220px-Avengersendgame.jpg",
                        fit: BoxFit.fill,
                      ),
                      borderRadius: 12,
                      elevation: 3,
                    );
                  }
                },
                title: LocaleKeys.homePage_newReleasedPopularGames.tr(),
                itemCount: 5,
                itemHeight: 200),
            SizedBox(
              height: 20,
            ),
            CardListView(
                itemBuilder: (context, index) {
                  if (index == 0 || index == 4) {
                    return const SizedBox(
                      width: 12,
                    );
                  } else {
                    return HomePageGameCard(
                      onTap: () {},
                      child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/tr/thumb/6/67/Avengersendgame.jpg/220px-Avengersendgame.jpg",
                        fit: BoxFit.fill,
                      ),
                      borderRadius: 12,
                      elevation: 3,
                    );
                  }
                },
                title: LocaleKeys.homePage_bestOfYear.tr(),
                itemCount: 5,
                itemHeight: 200),
            SizedBox(
              height: 20,
            ),
            CardListView(
                itemBuilder: (context, index) {
                  if (index == 0 || index == 5) {
                    return const SizedBox(
                      width: 12,
                    );
                  } else {
                    return HomePageGameCard(
                      onTap: () {},
                      child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/tr/thumb/6/67/Avengersendgame.jpg/220px-Avengersendgame.jpg",
                        fit: BoxFit.fill,
                      ),
                      borderRadius: 12,
                      elevation: 3,
                    );
                  }
                },
                title: LocaleKeys.homePage_bestOfAllTime.tr(),
                itemCount: 5,
                itemHeight: 200),

            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
