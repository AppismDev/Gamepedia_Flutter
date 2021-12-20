import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Init/Cache/locale_manager.dart';
import 'package:gamepedia/Core/Init/Theme/app_theme_dark.dart';
import 'package:gamepedia/Core/Init/Theme/app_theme_light.dart';

class ThemeProvider extends ChangeNotifier {
  final LocaleManager _localeManager = LocaleManager.instance;
  ThemeData _currentTheme = AppThemeLight.instance.theme;

  late ThemeEnums _currentAppThemeEnum;


  ThemeData get currentTheme => _currentTheme;
  ThemeEnums get currentAppThemeEnum => _currentAppThemeEnum;


  ThemeData get otherTheme {
    if(currentAppThemeEnum == ThemeEnums.LIGHT_MODE){
      return AppThemeDark.instance.theme;
    }else{
      return AppThemeLight.instance.theme;
    }
  }

  ThemeProvider(PreferencesKeys themePrefs){
    if(themePrefs == PreferencesKeys.DARK_THEME){
      _currentTheme = AppThemeDark.instance.theme;
      _currentAppThemeEnum = ThemeEnums.DARK_MODE;
    }else{
      _currentTheme = AppThemeLight.instance.theme;
      _currentAppThemeEnum = ThemeEnums.LIGHT_MODE;
    }
  }


  Future<void> changeTheme(PreferencesKeys themeEnum) async {
    if (themeEnum == PreferencesKeys.DARK_THEME) {
      _currentTheme = AppThemeDark.instance.theme;
      _currentAppThemeEnum = ThemeEnums.DARK_MODE;
      await _localeManager.setBoolValue(PreferencesKeys.LIGHT_THEME, true);
      await _localeManager.setBoolValue(PreferencesKeys.DARK_THEME, false);
    } else {
      _currentTheme = AppThemeLight.instance.theme;
      _currentAppThemeEnum = ThemeEnums.LIGHT_MODE;
      await _localeManager.setBoolValue(PreferencesKeys.DARK_THEME, true);
      await _localeManager.setBoolValue(PreferencesKeys.LIGHT_THEME, false);
    }

    notifyListeners();
  }

  Future<void> switchTheme() async {
    if (_localeManager.getBoolValue(PreferencesKeys.LIGHT_THEME)) {
      _currentTheme = AppThemeDark.instance.theme;
      _currentAppThemeEnum = ThemeEnums.DARK_MODE;
      await _localeManager.setBoolValue(PreferencesKeys.DARK_THEME, true);
      await _localeManager.setBoolValue(PreferencesKeys.LIGHT_THEME, false);
    } else {
      _currentTheme = AppThemeLight.instance.theme;
      _currentAppThemeEnum = ThemeEnums.LIGHT_MODE;
      await _localeManager.setBoolValue(PreferencesKeys.LIGHT_THEME, true);
      await _localeManager.setBoolValue(PreferencesKeys.DARK_THEME, false);
    }
    notifyListeners();
  }

}
