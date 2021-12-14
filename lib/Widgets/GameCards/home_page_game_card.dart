import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Views/DetailsPage/details_page.dart';


class HomePageGameCard extends StatefulWidget {
  GameModel gameModel;
  double? width;
  double? height;

  HomePageGameCard({Key? key,required this.gameModel, this.width, this.height}) : super(key: key);

  @override
  _HomePageGameCardState createState() => _HomePageGameCardState();
}

class _HomePageGameCardState extends State<HomePageGameCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        MaterialPageRoute route = MaterialPageRoute(builder: (context)=> GameDetailsPage(gameModel: widget.gameModel,));
        Navigator.of(context).push(route);
      },
      child: Align(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12)
          ),
          height: widget.height ?? 200,
          width: widget.width ?? 400,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.red,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "${widget.gameModel.name}",
                      style: context.theme.textTheme.headline6!
                          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
