import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GamepediaLogo extends StatelessWidget {

  double? size;

  GamepediaLogo({Key? key,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Game",
          style: GoogleFonts.prompt(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Color(0xffE50914),
            fontSize: size ?? 14
          ),
        ),
        Text(
          "pedia",
          style: GoogleFonts.prompt(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              fontSize: size ?? 14,
              color: context.currentAppThemeEnum == ThemeEnums.LIGHT_MODE
                  ? Colors.grey.shade800
                  : Colors.grey.shade200
          ),
        )

      ],
    );
  }
}
