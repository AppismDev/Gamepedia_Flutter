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

  late PreferencesKeys _currentAppThemeEnum;


  ThemeData get currentTheme => _currentTheme;
  PreferencesKeys get currentAppThemeEnum => _currentAppThemeEnum;

  ThemeProvider(PreferencesKeys themePrefs){
    if(themePrefs == PreferencesKeys.DARK_THEME){
      _currentTheme = AppThemeDark.instance.theme;
      _currentAppThemeEnum = PreferencesKeys.DARK_THEME;
    }else{
      _currentTheme = AppThemeLight.instance.theme;
      _currentAppThemeEnum = PreferencesKeys.LIGHT_THEME;
    }
  }


  Future<void> changeTheme(PreferencesKeys themeEnum) async {
    if (themeEnum == PreferencesKeys.LIGHT_THEME) {
      _currentTheme = AppThemeDark.instance.theme;
      _currentAppThemeEnum = PreferencesKeys.DARK_THEME;
      await _localeManager.setBoolValue(PreferencesKeys.DARK_THEME, true);
      await _localeManager.setBoolValue(PreferencesKeys.LIGHT_THEME, false);
    } else {
      _currentTheme = AppThemeLight.instance.theme;
      _currentAppThemeEnum = PreferencesKeys.LIGHT_THEME;
      await _localeManager.setBoolValue(PreferencesKeys.LIGHT_THEME, true);
      await _localeManager.setBoolValue(PreferencesKeys.DARK_THEME, false);
    }

    notifyListeners();
  }
  Future<void> switchTheme() async {
    if (_localeManager.getBoolValue(PreferencesKeys.LIGHT_THEME)) {
      _currentTheme = AppThemeDark.instance.theme;
      _currentAppThemeEnum = PreferencesKeys.DARK_THEME;
      await _localeManager.setBoolValue(PreferencesKeys.DARK_THEME, true);
      await _localeManager.setBoolValue(PreferencesKeys.LIGHT_THEME, false);
    } else {
      _currentTheme = AppThemeLight.instance.theme;
      _currentAppThemeEnum = PreferencesKeys.DARK_THEME;
      await _localeManager.setBoolValue(PreferencesKeys.LIGHT_THEME, true);
      await _localeManager.setBoolValue(PreferencesKeys.DARK_THEME, false);
    }
    notifyListeners();
  }

}
