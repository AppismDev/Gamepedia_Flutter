import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/SearchPage/ViewModel/search_page_viewmodel.dart';
import 'package:gamepedia/Widgets/GameCards/GameSearchCard/game_search_card.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchPageViewModel _viewModel = SearchPageViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GamepediaLogo(
          size: 18,
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.lowValue),
            child: Text(
              "Bulmak İstediğiniz Oyunu Arayın",
              style: context.textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.lowValue, horizontal: context.mediumValue),
            child: TextField(
              controller: _viewModel.controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                _viewModel.searchGames();
              },
              onChanged: (value) {
                _viewModel.query = value;
              },
              decoration: InputDecoration(
                hintText: 'Oyun Arayın',
                suffixIcon: IconButton(
                  onPressed: () {
                    _viewModel.searchGames();
                  },
                  icon: Icon(Icons.search),
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    _viewModel.clearSearchText();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ),
          ),
          Observer(
            builder: (context) {
              if (_viewModel.searchedGames.isEmpty) {
                if (_viewModel.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (_viewModel.query.isEmpty || !_viewModel.isQueryFinished) {
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
                return Column(
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
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
