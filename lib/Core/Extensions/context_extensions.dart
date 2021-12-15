import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

extension ContextExtensions on BuildContext{

  MediaQueryData get mediaQuery => MediaQuery.of(this);

}


extension MediaQueryExtensions on BuildContext{
  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;
  double get screenHeight => mediaQuery.size.height;
  double get safeScreenHeight => mediaQuery.size.height- mediaQuery.padding.top - mediaQuery.padding.bottom;
  double get screenWidth => mediaQuery.size.width;

}

extension ThemeExtensions on BuildContext{


  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ButtonThemeData get buttonThemeData => theme.buttonTheme;
  CardTheme get cardTheme => theme.cardTheme;
  IconThemeData get iconThemeData => theme.iconTheme;
  ColorScheme get colors => theme.colorScheme;
  ThemeEnums get currentAppThemeEnum => Provider.of<ThemeProvider>(this).currentAppThemeEnum;
  // ThemeData get otherTheme => Provider.of<ThemeProvider>(this).otherTheme;
  // MaterialColor get primarySwatchColor => Provider.of<ThemeProvider>(this).currentPrimarySwatch;
}

extension NumberExtension on BuildContext {
  double get veryLowValue => dynamicHeight(0.005);
  double get lowValue => dynamicHeight(0.015);
  double get mediumValue => dynamicHeight(0.03);
  double get highValue => dynamicHeight(0.05);
}

//TODO padding1 padding2 gibi yap
extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAllVeryLow => EdgeInsets.all(veryLowValue);
  EdgeInsets get paddingAllLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingAllMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingAllHigh => EdgeInsets.all(highValue);
  EdgeInsets get paddingHorizontalLow =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingHorizontalMedium =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHorizontalHigh =>
      EdgeInsets.symmetric(horizontal: highValue);
  EdgeInsets get paddingVerticalLow => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingVerticalMedium =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingVerticalHigh =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingOnlyTopLow => EdgeInsets.only(top: lowValue);
  EdgeInsets get paddingOnlyTopMedium => EdgeInsets.only(top: mediumValue);
  EdgeInsets get paddingOnlyTopHigh => EdgeInsets.only(top: highValue);

  EdgeInsets get paddingOnlyBottomLow => EdgeInsets.only(bottom: lowValue);
  EdgeInsets get paddingOnlyBottomMedium => EdgeInsets.only(bottom: mediumValue);
  EdgeInsets get paddingOnlyBottomHigh => EdgeInsets.only(bottom: highValue);

  EdgeInsets get paddingOnlyLeftLow => EdgeInsets.only(left: lowValue);
  EdgeInsets get paddingOnlyLeftMedium => EdgeInsets.only(left: mediumValue);
  EdgeInsets get paddingOnlyLeftHigh => EdgeInsets.only(left: highValue);

  EdgeInsets get paddingOnlyRightLow => EdgeInsets.only(right: lowValue);
  EdgeInsets get paddingOnlyRightMedium => EdgeInsets.only(right: mediumValue);
  EdgeInsets get paddingOnlyRightHigh => EdgeInsets.only(right: highValue);



}