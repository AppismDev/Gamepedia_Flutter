import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/genre_lite_model.dart';
import 'package:gamepedia/Widgets/Bounce/bounce_without_hover.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreLiteCard extends StatelessWidget {
  GenreLiteCard({Key? key, required this.genreLiteModel}) : super(key: key);

  late GenreLiteModel genreLiteModel;

  @override
  Widget build(BuildContext context) {
    return BounceWithoutHover(
      onPressed: (){},
      duration: Duration(milliseconds: 100),
      child: Container(
        height: 44,
        width: 150,
        child: Center(
          child: Padding(
            padding: context.paddingAllVeryLow,
            child: Text(
              "${genreLiteModel.name}",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                color: Colors.grey.shade100,
                fontSize: 16,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: context.theme.primaryColor.withAlpha(160),
          border: Border.all(
            color: context.theme.primaryColor,
            width: 3
          )
        ),
      ),
    );
  }
}
