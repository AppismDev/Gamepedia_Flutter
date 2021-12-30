import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Models/ApiModels/theme_model.dart';
import 'package:gamepedia/Widgets/Bounce/bounce_without_hover.dart';

class ThemeChip extends StatelessWidget {
  final ThemeModel themeModel;
  bool isSelected;
  Color selectedColor;
  VoidCallback onPressed;

  ThemeChip(
      {Key? key,
      required this.themeModel,
      this.isSelected = false,
      required this.selectedColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BounceWithoutHover(
        onPressed: onPressed,
        duration: Duration(milliseconds: 100),
        child: Chip(
          backgroundColor: isSelected
              ? selectedColor
              : (context.currentAppThemeEnum == ThemeEnums.LIGHT_MODE ? Colors.grey.shade300 : Colors.grey.shade800),
          elevation: 2,
          padding: EdgeInsets.all(10),
          label: Text(
            "${themeModel.name}",
            style: context.textTheme.bodyText2!.copyWith(
              color: context.currentAppThemeEnum == ThemeEnums.LIGHT_MODE
                  ? isSelected
                      ? Colors.grey.shade200
                      : Colors.grey.shade700
                  : Colors.grey.shade200,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
