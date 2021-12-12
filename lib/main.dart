import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Core/Init/Cache/locale_manager.dart';
import 'package:gamepedia/Core/Init/Notifier/application_providers.dart';
import 'package:gamepedia/Core/Init/Theme/app_theme_dark.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:gamepedia/Views/SplashScreen/View/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesKeys _themeKey = await init();
  runApp(MultiProvider(providers: [...ApplicationProviders.instance.dependItems(_themeKey)], child: Gamepedia()));
}

Future<PreferencesKeys> init() async {
  LocaleManager _localeManager = LocaleManager.instance;
  await LocaleManager.preferencesInit();
  PreferencesKeys preferencesKeys = _localeManager.getBoolValue(PreferencesKeys.DARK_THEME) ? PreferencesKeys.DARK_THEME : PreferencesKeys.LIGHT_THEME;
  return preferencesKeys;

}

class Gamepedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: SplashScreen(),
    );
  }
}
