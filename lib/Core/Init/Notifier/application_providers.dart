import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ApplicationProviders{
  static ApplicationProviders _instance = ApplicationProviders._init();
  static ApplicationProviders get instance => _instance;

  ApplicationProviders._init();

  List<SingleChildWidget> dependItems(PreferencesKeys themePrefs) => [ChangeNotifierProvider(create: (context) =>ThemeProvider(themePrefs) ), ];

 }