import 'package:flutter/cupertino.dart';

class LanguageManager{
  static LanguageManager? _instance;
  static LanguageManager get instance{
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = Locale('en');
  final trLocale = Locale('tr');

  List<Locale> get supportedLocales => [trLocale, enLocale];
 }