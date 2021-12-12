import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Core/Extensions/window_extensions.dart';
import 'package:gamepedia/Core/Init/Cache/locale_manager.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _themeProvider.switchTheme();
        },
      ),
      appBar: AppBar(
        title: Text("aaaaaa"),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            Center(
              child: Text("aaaaaaaaaaa"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("asdasd"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("asdasd"),
            ),
            TextField()
          ],
        ),
      ),
    );
  }
}
