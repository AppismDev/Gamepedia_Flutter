import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/image_enums.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/game_model.dart';
import 'package:gamepedia/Widgets/Bounce/bounce_without_hover.dart';

class PlatformChip extends StatelessWidget {
  PlatformChip({Key? key, required this.platform, required this.colorIndex}) : super(key: key);

  GameModelPlatforms platform;
  int colorIndex;
  AppConstants _appConstants = AppConstants.instance;


  @override
  Widget build(BuildContext context) {
    return BounceWithoutHover(
      onPressed: (){},
      duration: Duration(milliseconds: 100),
      child: Chip(
        padding: context.paddingAllLow,
        label: Text(
            "${platform.name}",
          style: TextStyle(
            color: Colors.grey.shade200,
            fontWeight: FontWeight.w600
          ),
        ),
        elevation: 16,
        backgroundColor: Colors.primaries[colorIndex%Colors.primaries.length],
      ),
    );
  }
}
