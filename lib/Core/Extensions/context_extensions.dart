import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextExtensions on BuildContext{

  MediaQueryData get mediaQuery => MediaQuery.of(this);

}


extension MediaQueryExtensions on BuildContext{

  double get screenHeight => this.mediaQuery.size.height;
  double get screenWidth => this.mediaQuery.size.width;

}

extension ThemeExtensions on BuildContext{


  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ButtonThemeData get buttonThemeData => theme.buttonTheme;
  CardTheme get cardTheme => theme.cardTheme;
  IconThemeData get iconThemeData => theme.iconTheme;
  ColorScheme get colors => theme.colorScheme;
  // AppThemes get currentAppThemeEnum => Provider.of<ThemeProvider>(this).currentAppThemeEnum;
  // ThemeData get otherTheme => Provider.of<ThemeProvider>(this).otherTheme;
  // MaterialColor get primarySwatchColor => Provider.of<ThemeProvider>(this).currentPrimarySwatch;
}