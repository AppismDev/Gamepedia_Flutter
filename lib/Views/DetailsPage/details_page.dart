import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Widgets/Clipper/arc_clipper.dart';

class GameDetailsPage extends StatelessWidget {
  const GameDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        backgroundColor: Colors.transparent,
        title: Text("Gamepedia"),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: ProfileClipper(),
                child: Container(
                  width: context.screenWidth,
                  height: context.screenHeight / 2,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text("asdasd"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
