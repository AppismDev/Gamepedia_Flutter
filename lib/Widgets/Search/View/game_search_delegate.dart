import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/search_model.dart';
import 'package:gamepedia/Widgets/GameCards/GameSearchCard/game_search_card.dart';
import 'package:gamepedia/Widgets/Search/ViewModel/game_search_delegate_viewmodel.dart';

class CustomSearchDelegate extends SearchDelegate {
  GameSearchDelegateViewModel _viewModel = GameSearchDelegateViewModel();
  AppConstants _appConstants = AppConstants.instance;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          _viewModel.clearSearchGames();
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _viewModel.searchGames(query);


    return buildBody();

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using

    return Column(
      children: <Widget>[
        //Build the results based on the searchResults stream in the searchBloc,
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return buildBody();
  }
  Observer buildBody() {
    return Observer(
      builder: (context) {
        if (_viewModel.searchedGames.isEmpty) {
          if (_viewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (query.isEmpty || !_viewModel.isQueryFinished) {
              return Center(
                child: Text("Aramak için harf giriniz"),
              );
            } else {
              return Center(
                child: Text("Sonuç bulunamadı"),
              );
            }
          }
        } else {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_viewModel.isLoading) ...[
                  Padding(
                    padding: context.paddingAllLow,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sonuçlar Aranıyor",
                          style: context.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Center(
                            child: Padding(
                          padding: context.paddingHorizontalLow,
                          child: SizedBox(width: 15, height: 15, child: CircularProgressIndicator()),
                        )),
                      ],
                    ),
                  )
                ] else ...[
                  Padding(
                    padding: context.paddingAllLow,
                    child: Text(
                      "Search Result (${_viewModel.searchedGames.length})",
                      style: context.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _viewModel.searchedGames.length,
                  itemBuilder: (context, index) {
                    GameModel? _currentGame = _viewModel.searchedGames[index];
                    if (_currentGame != null) {
                      return GameSearchCard(gameModel: _currentGame);
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildScoreStartsWidget(BuildContext context, SearchModel searchModel) {
    return SizedBox(
      height: context.highValue,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: context.paddingOnlyRightLow,
              child: Icon(FontAwesome5Solid.star,
                  size: 20,
                  color: searchModel.rating == null
                      ? Colors.grey.shade400
                      : index >= (searchModel.rating! / 20).roundToDouble()
                          ? Colors.grey.shade700
                          : Colors.orange),
            );
          }),
    );
  }

  String addAllGenres(List<Genres> list) {
    String genres = "";
    if (list.isEmpty) return "";

    for (int i = 0; i < list.length; i++) {
      if (list[i].name != null) {
        if (i == list.length - 1) {
          genres += "${list[i].name}";
        } else {
          genres += "${list[i].name}, ";
        }
      }
    }

    return genres;
  }

  Align buildSuggestion() {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
          width: 200,
          height: 100,
          child: Center(child: Text("Suggestion")),
        ),
      ),
    );
  }
}
