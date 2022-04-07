import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Providers/Favorites/favorites_provider.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:gamepedia/Views/FavoritesPage/ViewModel/favorites_page_viewmodel.dart';
import 'package:gamepedia/Widgets/Cards/game_filter_card.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoritesPageViewModel _favoritesPageViewModel = FavoritesPageViewModel();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   final FavoritesProvider _favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesProvider _favoritesProvider = Provider.of<FavoritesProvider>(context, listen: true);

    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (_favoritesProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: context.paddingAllLow,
                    child: Text(
                      "Favoriler",
                      style: context.textTheme.headline5,
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: context.dynamicHeight(0.42)),
                    itemCount: _favoritesProvider.favoriteGames.length,
                    itemBuilder: (context, index) {
                      GameModel? _currentGame = _favoritesProvider.favoriteGames[index];
                      return GameFilterCard(gameModel: _currentGame);
                    },
                  ),
                ],
              ),
            );
          }
        },
        future: _favoritesProvider.getFavoriteGames(),
      ),
      // body: _favoritesProvider.isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : Text("${_favoritesProvider.favoriteGames.length}"),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: GamepediaLogo(
        size: 18,
      ),
    );
  }
}
