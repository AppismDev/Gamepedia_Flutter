import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Core/Init/Cache/locale_manager.dart';
import 'package:gamepedia/Core/Init/Language/language_manager.dart';
import 'package:provider/provider.dart';

class LanguageProvider extends ChangeNotifier {
  LocaleManager _localeManager = LocaleManager.instance;
  LanguageManager _languageManager = LanguageManager.instance;
  late Locale currentLocale;

  LanguageProvider() {
    if (_localeManager.getStringValue(PreferencesKeys.LANGUAGE).isEmpty) {
      print("empty");
      currentLocale = _languageManager.trLocale;
    } else {
      currentLocale = Locale((_localeManager.getStringValue(PreferencesKeys.LANGUAGE)));
    }
  }

  setCurrentLocale(Locale locale, BuildContext context) async {
    await _localeManager.setStringValue(PreferencesKeys.LANGUAGE, locale.languageCode);
    context.setLocale(locale);
    currentLocale = locale;
    notifyListeners();
  }
}
