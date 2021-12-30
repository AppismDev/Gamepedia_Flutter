import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:shimmer/shimmer.dart';

class ChipShimmer extends StatelessWidget {
  const ChipShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: Shimmer.fromColors(
        baseColor: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade900 : Colors.grey.shade300,
        highlightColor:
            context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.grey.shade800 : Colors.grey.shade200,
        child: Wrap(
          spacing: 6,
          children: [
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 20),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 10),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 40),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 25),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 40),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 10),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 60),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 30),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 30),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 20),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 10),
            ),
            Chip(
              padding: EdgeInsets.all(10),
              elevation: 2,
              label: Text(" " * 40),
            ),
          ],
        ),
      ),
    );
  }
}
