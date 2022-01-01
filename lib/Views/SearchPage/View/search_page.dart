import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Views/SearchPage/ViewModel/search_page_viewmodel.dart';
import 'package:gamepedia/Widgets/Bounce/bounce.dart';
import 'package:gamepedia/Widgets/GameCards/GameCard/game_card.dart';
import 'package:gamepedia/Widgets/GameCards/GameSearchCard/game_search_card.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  SearchPageViewModel _viewModel = SearchPageViewModel();

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _viewModel.getDiscover();

    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        _viewModel.setIsShowHistory(true);
      }else{
        _viewModel.setIsShowHistory(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE
          ? Colors.grey[850]
          : Colors.white,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTapDown: (_) {
          if(_focusNode.hasFocus) _focusNode.unfocus();
        },
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight,
      child: Column(
        children: [
          buildSearchPanel(),
          Expanded(
            child: buildContent(),
          ),
        ],
      ),
    );
  }

  Widget buildSearchPanel() {
    return Container(
      width: context.screenWidth,
      height: context.dynamicHeight(0.25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.screenHeight - context.safeScreenHeight),
          // Title And Back Icon
          Row(
            children: [
              Bounce(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: context.paddingAllMedium,
                      child: Icon(
                          Ionicons.ios_arrow_back,
                        size: 30,
                      ),
                    ),
                  ),
              ),
              Expanded(
                // TODO I18N
                child: Text(
                  "Gamepedia'da Ara",
                  textAlign: TextAlign.left,
                    style: GoogleFonts.prompt(
                        fontStyle: FontStyle.italic,
                        fontSize: 24
                    ),
                ),
              )
            ],
          ),
          SizedBox(height: context.lowValue),
          // Search Bar
          Padding(
            padding: context.paddingHorizontalMedium,
            child: Container(
              width: context.screenWidth,
              height: context.dynamicHeight(0.08),
              child: Row(
                children: [
                  // Seaarch Icon
                  Padding(
                    padding: context.paddingAllLow,
                    child: Icon(Ionicons.ios_search),
                  ),
                  Expanded(
                      child: TextField(
                        focusNode: _focusNode,
                        keyboardType:TextInputType.name,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (String? text) async{
                          if(text != null){
                            _viewModel.setSearchText(text);
                            _viewModel.setIsShowHistory(false);
                            await _viewModel.searchGame();
                          }
                        },
                        style: GoogleFonts.prompt(
                            fontStyle: FontStyle.italic,
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                          hintText: "Search for games",
                          hintStyle: GoogleFonts.prompt(
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),
                        ),
                      ),
                  ),
                  SizedBox(width: context.lowValue),
                  Bounce(
                    onPressed: () {  },
                    duration: Duration(milliseconds: 100),
                    child: Container(
                      width: context.dynamicHeight(0.064),
                      height: context.dynamicHeight(0.064),
                      child: Icon(Octicons.settings),
                      decoration: BoxDecoration(
                        color: context.currentAppThemeEnum == ThemeEnums.DARK_MODE
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                  ),
                  SizedBox(width: context.lowValue),
                ],
              ),
              decoration: BoxDecoration(
                color: context.currentAppThemeEnum == ThemeEnums.DARK_MODE
                    ? Colors.grey.shade900
                    : Color(0xffeaeaea),
                borderRadius: BorderRadius.circular(12)
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget buildContent() {
    return Container(
      child: Observer(
        builder: (_){

          if(_viewModel.loadingContent){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(_viewModel.isShowHistory){
            return buildHistory();
          }else{
            if(_viewModel.isShowDiscover){
              return buildDiscover();
            }
            if(_viewModel.searchedGames.isNotEmpty){
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _viewModel.searchedGames.length,
                itemBuilder: (context,index){
                  return GameSearchCard(gameModel: _viewModel.searchedGames[index]);
                },
              );
            }else{
              return buildNotFound();
            }
          }
        },
      ),
      decoration: BoxDecoration(
          color: context.currentAppThemeEnum == ThemeEnums.DARK_MODE
              ? Colors.grey.shade900
              : Color(0xfff0f0f0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          )
      ),
    );
  }

  Center buildHistory() {
    return Center(
            child: Text("Arama Geçmişini Göster"),
          );
  }

  Center buildNotFound() {
    return Center(
              child: Text("Bulunamadı !"),
            );
  }

  Widget buildDiscover() {
    return Observer(builder: (_){
      if(_viewModel.discover.isEmpty){
        return Center(
          child: CircularProgressIndicator(),
        );
      }else{
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.lowValue ,
                  vertical: context.lowValue
              ),
              child: Container(
                width: double.infinity,
                child: Text(
                  "Son Baktıklarım",
                  style: context.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),

            // TODO: En son detaay sayfasına girdiği 10 oyunu bu alanda listelenecek
            Spacer(),


            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.lowValue ,
                vertical: context.veryLowValue
              ),
              child: Container(
                width: double.infinity,
                child: Text(
                  "Keşfet Kuyruğu",
                  style: context.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Container(
              height: context.dynamicHeight(0.3),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                cacheExtent: context.screenWidth * 5,
                separatorBuilder: (context, index) {
                  return SizedBox(width: context.lowValue);
                },
                itemCount: _viewModel.discover.length + 2,
                itemBuilder: (context,index){
                  if (index == 0 || index == _viewModel.discover.length + 1) {
                    return SizedBox(
                      width: context.veryLowValue,
                    );
                  }
                  return GameCard(
                    gameModel: _viewModel.discover[index - 1],
                  );
                },
              ),
            ),
            SizedBox(height: context.veryLowValue),
          ],
        );
      }
    });
  }

}
