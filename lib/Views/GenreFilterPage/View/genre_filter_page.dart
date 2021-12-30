import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Models/ApiModels/genre_lite_model.dart';
import 'package:gamepedia/Views/GenreFilterPage/ViewModel/genre_filter_page_viewmodel.dart';
import 'package:gamepedia/Widgets/Cards/game_filter_card.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:collection/collection.dart';

class GenreFilterPage extends StatefulWidget {
  List<GenreLiteModel?> genres;

  GenreFilterPage({Key? key, required this.genres}) : super(key: key);

  @override
  State<GenreFilterPage> createState() => _GenreFilterPageState();
}

class _GenreFilterPageState extends State<GenreFilterPage> {
  GenreFilterPageViewModel _viewModel = GenreFilterPageViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.getFilteredGames(widget.genres);
  }

  //TODO pagination eklenecek
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GamepediaLogo(
          size: 18,
        ),
      ),
      body: Observer(
        builder: (context) {
          if (_viewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: context.paddingHorizontalLow,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: widget.genres.mapIndexed(
                          (index, e) {
                            if (e == null) {
                              return SizedBox();
                            } else {
                              return Padding(
                                padding: context.paddingOnlyRightVeryLow,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Chip(
                                    backgroundColor: Colors.primaries[index % Colors.primaries.length].shade700,
                                    label: Text(
                                      "${e.name}",
                                      style: context.textTheme.bodyText2!.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  if (_viewModel.genreFilteredGames.isEmpty) ...[
                    Center(
                      child: Text("Eşleşen oyun bulunamadı :("),
                    )
                  ] else ...[
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisExtent: context.dynamicHeight(0.42)),
                      itemCount: _viewModel.genreFilteredGames.length,
                      itemBuilder: (context, index) {
                        GameModel? _currentGame = _viewModel.genreFilteredGames[index];
                        if (_currentGame != null) {
                          return GameFilterCard(gameModel: _currentGame);
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ]
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
