import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Constans/App/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Core/Init/Cache/locale_manager.dart';
import 'package:gamepedia/Core/Init/Language/language_manager.dart';
import 'package:gamepedia/Core/Init/Notifier/application_providers.dart';
import 'package:gamepedia/Core/Init/Theme/app_theme_dark.dart';
import 'package:gamepedia/Providers/Language/language_provider.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:gamepedia/Services/ApiService/api_service.dart';
import 'package:gamepedia/Views/SplashScreen/View/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesKeys _themeKey = await init();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [...ApplicationProviders.instance.dependItems(_themeKey)],
      child: EasyLocalization(
        path: ApplicationConstants.LANG_ASSET_PATH,
        supportedLocales: LanguageManager.instance.supportedLocales,
        child: Gamepedia(),
      ),
    ),
  );
}

Future<PreferencesKeys> init() async {
  LocaleManager _localeManager = LocaleManager.instance;
  await LocaleManager.preferencesInit();
  await EasyLocalization.ensureInitialized();
  PreferencesKeys preferencesKeys = _localeManager.getBoolValue(PreferencesKeys.DARK_THEME)
      ? PreferencesKeys.DARK_THEME
      : PreferencesKeys.LIGHT_THEME;
  return preferencesKeys;

}

class Gamepedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    context.setLocale(Provider.of<LanguageProvider>(context).currentLocale);
    return MaterialApp(
      title: 'Material App',
      supportedLocales: context.supportedLocales,
      locale:  Provider.of<LanguageProvider>(context).currentLocale,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: SplashScreen(),
    );
  }
}
